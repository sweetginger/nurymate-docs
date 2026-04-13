# Shopify Markets 다국가 연결 구조 조사

> 조사 기준일: 2026년 3월
> 관련 태스크: [17-9]

---

## 1. Shopify Markets 개요

Shopify Markets는 단일 Shopify 스토어에서 국가별로 다른 구매 경험(언어·통화·결제수단·가격·상품 노출 여부)을 제공하는 다국가 판매 프레임워크다. 기존에는 국가별로 별도 스토어(Expansion Store)를 운영해야 했으나, Markets 도입으로 하나의 관리자 화면에서 최대 50개 마켓(Primary 1 + Additional 49)을 관리할 수 있다.

**핵심 컨셉**
- **Primary Market**: 스토어 기본 국가 (보통 사업자 소재국)
- **Additional Market**: 추가 판매 대상 국가/지역 그룹
- **Market Context**: 바이어가 현재 속한 마켓 — 언어·통화·결제수단·가격 등 모든 로컬라이제이션이 이 컨텍스트에 묶임
- **Managed Markets**: Shopify가 세금·관세·현지 결제수단·배송 복잡도를 대행하는 고급 플랜 (기존 Global-e 파트너십 기반)

---

## 2. 마켓 자동 연결 로직 (IP → 마켓 라우팅)

### 2-1. 기본 탐지 메커니즘

Shopify는 방문자의 **접속 IP 주소(GeoIP)**와 **브라우저 언어(Accept-Language 헤더)** 를 조합해 최적 마켓을 판단한다.

```
방문자 접속
    ↓
IP → 국가 코드 추출 (GeoIP)
    ↓
해당 국가가 속한 마켓 조회 (국가는 오직 하나의 활성 마켓에만 속할 수 있음)
    ↓
마켓에 고유 URL(도메인/서브도메인/서브폴더)이 설정된 경우
    → 해당 URL로 HTTP 리디렉션
마켓이 Primary와 동일 URL을 공유하는 경우
    → URL 변경 없이 통화·언어 컨텍스트만 전환
```

### 2-2. 리디렉션 동작 세부

| 조건 | 동작 |
|------|------|
| 마켓에 고유 도메인/서브도메인/서브폴더 설정 | IP 기반 자동 HTTP 리디렉션 발생 |
| 마켓이 Primary와 URL 공유 | URL 유지, 내부 통화·언어 컨텍스트만 전환 |
| EU 규정 적용 국가 (EU 내부 도메인 간) | 자동 리디렉션 제한 — EU e-commerce 지침상 소비자 동의 없이 다른 국가 도메인으로 강제 이동 불가 |
| VPN 사용자 | GeoIP 오탐 가능 — 공식 문서에서 "GeoIP detection isn't perfect" 명시 |

### 2-3. 리디렉션 방지 설계

Shopify는 바이어가 마켓 전환 후 쿠키에 선택 정보를 저장한다. 이후 동일 바이어가 재방문하면 저장된 선호 마켓을 우선 적용한다. 단, 쿠키가 없는 SEO 봇은 미국 발 IP로 인식되어 Primary Market으로 라우팅되는 특성이 있다.

### 2-4. Storefront API에서의 마켓 컨텍스트

개발자가 직접 마켓 컨텍스트를 지정할 때는 `@inContext` 지시자를 사용한다.

```graphql
query @inContext(country: KR, language: KO) {
  product(handle: "example") {
    title
    priceRange { minVariantPrice { amount currencyCode } }
  }
}
```

컨텍스트가 설정되면 GraphQL 응답 extensions에 적용된 국가·언어 코드가 반환된다.

---

## 3. 다국어 번역 적용 기준

### 3-1. 언어 적용 우선순위

Shopify Markets의 언어 결정은 **마켓 설정(Market Language)이 기반(Base)이고, 브라우저 언어는 그 위에서 선택적으로 작동**한다.

```
1순위: URL에 포함된 언어 코드 (예: /fr-ca → 프랑스어 강제 적용)
2순위: 마켓에 브라우저 언어 리디렉션 활성화 시 — Accept-Language 헤더 감지
3순위: 마켓의 기본 언어 (Default Language) 설정값
4순위: 스토어 전체 기본 언어 (Store Default Language)
```

### 3-2. 브라우저 언어 리디렉션 (2024-01-15 출시)

2024년 1월 Shopify는 Markets에 **언어 리디렉션 설정(Language Redirection)**을 도입했다. 이 기능을 활성화하면:

- 방문자 브라우저의 주언어(Primary Language)가 해당 마켓에 퍼블리시된 번역과 일치하는 경우, 자동으로 해당 언어 URL로 리디렉션
- 예시: 캐나다 마켓에서 프랑스어가 활성화된 상태에서, 브라우저 언어가 프랑스어인 방문자는 `example.ca/fr` 로 자동 전환

**전제 조건**: 언어가 스토어에 추가 → 해당 마켓에 배정 → 번역 완료 → 퍼블리시 — 4단계 모두 완료되어야 브라우저 언어 감지가 활성화됨

### 3-3. 마켓 언어와 브라우저 언어의 관계

- 마켓 설정이 **컨테이너** 역할: 어떤 언어를 제공할지 결정
- 브라우저 언어는 그 컨테이너 안에서 **최초 노출 언어**를 선택하는 역할
- 마켓에 없는 언어는 브라우저 언어가 달라도 적용되지 않음 → **마켓 설정 우선**

### 3-4. 국가 선택이 언어를 덮어쓰는 경우

"If the currently selected language is not supported by the selected country, it will be updated to the default language for that country" — 국가 선택이 언어를 재설정할 수 있으므로, 국가 선택기와 언어 선택기를 연동할 때 주의 필요

---

## 4. 결제수단 필터링 로직

### 4-1. 기준: 마켓 내 국가 구성 (IP 아님)

로컬 결제수단(Local Payment Methods) 표시 여부는 **바이어의 실시간 IP가 아닌, 마켓에 등록된 국가 구성**을 기준으로 관리자 화면에서 활성화 가능 여부가 결정된다.

```
마켓 구성 국가 → 해당 국가에서 지원하는 로컬 결제수단 목록 생성
→ 관리자가 Markets > 해당 마켓 > Payments 에서 활성/비활성 선택
→ 체크아웃에서 노출
```

예시:
- Belgium만 포함한 유럽 마켓 → Bancontact만 Payments 카드에 표시
- Belgium + Netherlands 포함 유럽 마켓 → Bancontact + iDEAL 모두 표시

### 4-2. 체크아웃 시 결제수단 최종 결정 기준

체크아웃 단계에서 결제수단이 실제로 표시되는 기준은 **배송 주소(Shipping Address) 국가**다.

- 방문자가 마켓 A(KR) 컨텍스트에서 쇼핑하다가 배송지를 JP로 입력하면 → 체크아웃이 마켓 B(JP) 컨텍스트로 재조정
- 배송지 변경 시 결제수단·통화·가격이 동적으로 리로드됨
- Shopify 공식: "Shopify's checkout will ensure that the prices and product availability are appropriate for the shipping address the customer eventually chooses"

### 4-3. Bancontact/iDEAL 등 로컬 결제수단 추가 조건

| 결제수단 | 표시 조건 |
|----------|-----------|
| Bancontact (BE) | 벨기에 위치 바이어 + EUR 결제 |
| iDEAL (NL) | 네덜란드 위치 바이어 + EUR 결제 |
| Klarna | 스칸디나비아·독일 등 지원 국가 |
| PayPal / Apple Pay | 글로벌 (국가 제한 낮음) |

조건 충족 기준은 "buyer location" — 실제 구현에서는 체크아웃 시 배송 주소 국가를 기준으로 판단

### 4-4. Managed Markets

Managed Markets 플랜에서는 Shopify가 더 많은 국가별 로컬 결제수단을 자동 제공하며, 관세·세금 처리까지 대행한다. 신규 로컬 결제수단이 지속 추가 중.

---

## 5. URL 구조

### 5-1. 세 가지 옵션

| 구조 | 예시 | 특징 |
|------|------|------|
| **서브폴더 (Subfolder)** | `example.com/en-ca` | SEO 도메인 파워 집중, 설정 간단, 언어코드+국가코드 조합 |
| **서브도메인 (Subdomain)** | `ca.example.com` | 도메인 분리 없이 국가 식별 가능 |
| **별도 도메인 (ccTLD)** | `example.ca`, `example.jp` | 로컬 신뢰도 최고, SEO 분산, 관리 복잡 |

### 5-2. 서브폴더 URL 형식

```
example.com/{언어코드}-{국가코드}

예:
example.com/en-ca    → 영어, 캐나다 마켓
example.com/fr-ca    → 프랑스어, 캐나다 마켓
example.com/ja-jp    → 일본어, 일본 마켓
example.com/ko-kr    → 한국어, 한국 마켓
```

언어 코드와 국가 코드 조합으로 마켓 내 다국어도 각각 고유 URL을 가짐

### 5-3. 2023년 5월 이후 기본값 변경

2023년 5월 23일부터 신규 단일 국가 마켓 생성 시 **서브폴더가 자동 생성되지 않음**. 기본값이 Primary Market과 동일 URL 구조로 변경됨. 서브폴더는 선택적으로 개별 마켓에서 활성화 가능.

### 5-4. SEO 자동 처리

Shopify는 마켓별 URL에 `hreflang` 태그를 자동 삽입하여 검색엔진이 각 국가/언어 버전을 올바르게 인식하도록 지원한다.

### 5-5. URL 하드코딩 주의사항

Shopify 공식: "Avoid hardcoding URL when integrating or linking to the online store." 하드코딩된 경로는 방문자를 기본값으로 강제 이동시켜 언어·통화 컨텍스트를 파괴함.

---

## 6. 셀메이트CM 설계 시사점

| Shopify Markets 기능 | 셀메이트CM 채택 여부 | 이유 |
|--------------------|----------------|------|
| IP → 국가 → 마켓 자동 라우팅 | **채택 (변형)** | 접속 IP 기반 국가 감지 후 언어·통화 컨텍스트 자동 전환. 단, 강제 리디렉션 대신 배너 추천 방식 채택 (EU 규정 대응 + UX 친화) |
| 마켓 기준 언어 설정 (컨테이너) | **채택** | 셀러가 판매 마켓별로 지원 언어를 명시적으로 설정. 브라우저 언어는 그 안에서 선택 표시에 활용 |
| 브라우저 언어 리디렉션 (Language Redirection) | **변형 채택** | 자동 리디렉션 대신, 브라우저 언어 감지 후 언어 선택 배너 표시 (캐싱 문제 및 봇 오탐 방지) |
| 서브폴더 URL 구조 | **채택 우선** | `sellmatecm.com/ja-jp`, `sellmatecm.com/ko-kr` 형식. 도메인 파워 집중 + 관리 단순화. ccTLD는 MAU 증가 후 검토 |
| 결제수단 마켓별 활성화 | **채택** | 마켓에 포함된 국가의 로컬 결제수단을 관리자가 명시적으로 활성화. 체크아웃 시 배송 주소 국가 기준으로 최종 표시 |
| 배송 주소 기준 결제수단 최종 결정 | **채택** | 바이어 IP가 아닌 실제 배송지 국가로 결제수단·통화 최종 확정 → 해외 거주 한국인 등 예외 케이스 처리 가능 |
| hreflang 자동 삽입 | **채택** | URL 구조 확정 후 서버 렌더링 단계에서 hreflang 자동 생성 |
| ccTLD 별도 도메인 | **미채택 (단계적 검토)** | 초기에는 서브폴더로 통합 운영. 일본·동남아 등 특정 마켓 MAU 임계치 도달 시 ccTLD 전환 검토 |
| Managed Markets (관세·세금 대행) | **미채택 (외부 파트너 검토)** | 초기 주요 마켓(한국↔일본)은 수기 대응 가능. 동남아·미주 확장 시 관세 자동화 솔루션 도입 검토 |
| 마켓별 상품 노출 제어 | **채택** | 셀러가 특정 국가에서만 상품을 판매할 수 있도록 마켓별 카탈로그 접근 제어 기능 설계 |

### 6-1. 셀메이트CM 전용 고려 사항

**Shopify와의 차이점**:
- Shopify는 머천트(셀러)가 직접 운영하는 단일 브랜드 스토어 기준
- 셀메이트CM은 **다수 셀러가 입점하는 마켓플레이스** → 마켓 컨텍스트가 플랫폼 전체 단위 + 개별 셀러 스토어 단위 두 레이어로 존재

**이중 로컬라이제이션 레이어 필요**:
```
플랫폼 레이어: IP → 플랫폼 언어·통화 전환
    ↓
셀러 레이어: 셀러가 활성화한 마켓에 포함된 국가에만 상품 노출
    ↓
결제 레이어: 배송 주소 국가 기준 로컬 PG 선택
```

**셀러 마켓 설정 UX 설계 방향**:
- Shopify Markets의 "마켓에 국가 추가 → 결제수단 자동 제안" 패턴을 참고하여
- 셀러가 판매 국가를 선택하면 → 해당 국가 지원 결제수단 자동 추천 → 셀러가 활성화
- 복잡한 현지화 설정을 셀러가 직접 하지 않아도 되는 가이드 플로우 구성

---

## 참고 출처

- [Shopify Help Center — Set up automatic storefront redirection](https://help.shopify.com/en/manual/international/automatic-redirection)
- [Shopify Dev — Detect and set a visitor's optimal localization](https://shopify.dev/docs/storefronts/themes/markets/localization-discovery)
- [Shopify Dev — Localization detection (Hydrogen)](https://shopify.dev/docs/storefronts/headless/hydrogen/markets/locale-detection)
- [Shopify Dev — About Shopify Markets](https://shopify.dev/docs/apps/build/markets)
- [Shopify Dev — Contextual queries (@inContext)](https://shopify.dev/docs/storefronts/headless/building-with-the-storefront-api/in-context)
- [Shopify Dev — Support multiple currencies and languages](https://shopify.dev/docs/storefronts/themes/markets/multiple-currencies-languages)
- [Shopify Help Center — Local payment methods](https://help.shopify.com/en/manual/payments/shopify-payments/local-payment-methods)
- [Shopify Help Center — Payments (Markets)](https://help.shopify.com/en/manual/markets/payments)
- [Shopify Help Center — International domains](https://help.shopify.com/en/manual/markets/international-domains/setting-up-unique-urls/set-up-urls)
- [Shopify Changelog — Language redirection for translated storefronts](https://changelog.shopify.com/posts/redirect-visitors-to-translated-storefronts-based-on-their-browser-language)
- [Shopify Changelog — Subfolders no longer default for new Markets](https://changelog.shopify.com/posts/subfolders-are-no-longer-created-by-default-for-new-markets)
- [Shopify Blog — Grow Your Business Globally With Shopify Markets](https://www.shopify.com/blog/shopify-markets)
- [Shopify Community — Store language vs Market language confusion](https://community.shopify.com/c/technical-q-a/store-language-vs-market-language-confusion/td-p/1524555)
