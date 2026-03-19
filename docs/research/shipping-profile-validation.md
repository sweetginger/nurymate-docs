# 발송 프로필 관리 기능 필요성 검증

> 조사 기준일: 2026년 3월
> 관련 태스크: [17-11]

---

## 1. 셀러 규모별 발송 프로필 필요성 분석

### 1.1 분석 프레임

"발송 프로필"이란 셀러가 주문을 처리할 때 사용하는 발송 출발지(창고·사업장)·택배사·배송 가능 지역·통관 정보의 묶음이다. 셀러가 하나의 발송지에서 하나의 택배사만 이용한다면 프로필 개념은 불필요하다. 복수의 발송지 또는 복수의 택배사를 운영할 때 비로소 "프로필 단위 관리"의 가치가 생긴다.

### 1.2 소호 셀러 (1인, 단일 발송처)

| 항목 | 내용 |
|------|------|
| 운영 형태 | 자택 또는 소규모 작업실에서 직접 포장·발송 |
| 발송지 수 | 1개 (고정) |
| 이용 택배사 | 1~2개 (주로 CJ대한통운 또는 우체국) |
| 배송 국가 | 대부분 국내 단독. 해외는 EMS·국제소포로 산발 처리 |
| 복수 프로필 필요성 | **낮음** |

소호 셀러는 발송지 1개, 택배사 1개로 운영하는 것이 일반적이다. 이들에게 복수 프로필 등록 UI를 강제하면 온보딩 마찰이 오히려 증가한다. MVP에서는 기본 발송지 1개 + 기본 택배사 선택으로 충분하되, 이후 추가 발송지를 등록할 수 있는 확장 경로를 열어두는 것이 적합하다.

### 1.3 중소 셀러 (한국+일본 복수 창고)

| 항목 | 내용 |
|------|------|
| 운영 형태 | 한국 본사 창고 + 일본 현지 3PL 창고 병행 운영 |
| 발송지 수 | 2개 이상 (국가 단위로 분리) |
| 이용 택배사 | 한국: CJ대한통운·한진·롯데 / 일본: 야마토·사가와·일본우편 |
| 배송 국가 | 한국→국내+해외, 일본→일본 내 + 인접 국가 |
| 복수 프로필 필요성 | **높음** |

이 규모의 셀러는 창고 위치에 따라 이용 가능한 택배사가 완전히 다르고, 발송지별 배송 가능 국가·지역도 다르다. 예를 들어 한국 창고에서 발송하는 경우 국제배송 통관 서류(수출신고·HS코드)가 필요하지만, 일본 창고에서 일본 내 배송이라면 통관 절차가 불필요하다. 주문 생성 시 "어떤 창고에서 발송할지"를 프로필 단위로 선택하는 UX가 필요하다.

### 1.4 기업형 셀러 (국가별 3PL 운영)

| 항목 | 내용 |
|------|------|
| 운영 형태 | 한국·일본·동남아 각국별 3PL 제휴, 글로벌 OMS 연동 |
| 발송지 수 | 3개 이상 (국가별 다수) |
| 이용 택배사 | 국가별로 상이한 캐리어 계약 |
| 배송 국가 | 국가별로 서비스 범위 구분 운영 |
| 복수 프로필 필요성 | **필수** |

기업형 셀러는 발송 국가에 따른 세관 번호(EORI·통관고유부호), HS코드 기본값, 발송인 정보가 프로필마다 상이하다. OMS·WMS 시스템과 연동 시 프로필 ID를 기준으로 배송 처리 플로우가 분기되어야 하므로, 발송 프로필을 독립된 엔티티로 관리하는 데이터 모델이 필수다.

### 1.5 셀러 규모별 요약

| 셀러 유형 | 발송지 수 | 복수 프로필 필요성 | MVP 포함 여부 |
|----------|---------|-----------------|------------|
| 소호 (1인) | 1 | 낮음 | 기본 설정으로 충분 |
| 중소 (한+일 창고) | 2~3 | 높음 | 프로필 추가 기능 필요 |
| 기업형 (다국 3PL) | 3+ | 필수 | 완전한 프로필 관리 UI 필요 |

---

## 2. 경쟁사 발송 프로필 구현 방식 벤치마크

### 2.1 Shopify Locations + Shipping Profiles

#### 구조 개요

Shopify는 Location과 Delivery Profile(DeliveryProfile) 두 개념을 분리하여 관리한다.

```
DeliveryProfile (배송 프로필)
├── locationGroups (발송지 그룹)
│   ├── location[] (창고·거점 묶음)
│   └── locationGroupZones (배송 가능 구역)
│       ├── zone[] (국가/지역 그룹)
│       └── methodDefinitions[] (배송 방식 + 요금)
│           ├── DeliveryRateDefinition (고정 요금)
│           └── DeliveryParticipant (동적 요금 — Carrier Service API 연동)
└── products[] (이 프로필이 적용되는 상품 목록)
```

**핵심 동작 원리**:
- 셀러는 창고(Location)를 여러 개 등록하고, 배송 프로필 내에서 창고를 "Location Group"으로 묶는다.
- 각 Location Group마다 독립적인 배송 구역(Zone)과 배송비를 설정할 수 있다.
- 상품별로 어떤 배송 프로필을 사용할지 지정한다. 즉 "이 상품은 한국 창고에서만 발송", "저 상품은 일본 창고에서도 발송 가능" 구분이 가능하다.

#### 2025년 중요 변경 사항

2025년 7월~9월, Shopify는 모든 스토어를 **"설정된 배송 구역 내에서만 판매(Sell only within configured shipping zones)"** 모드로 전환 완료했다. 이로 인해 각 Location이 서비스할 배송 구역을 명시적으로 지정하지 않으면 해당 Location의 재고가 고객에게 노출되지 않는다. 이는 복수 창고 운영 셀러에게 배송 프로필 설정이 선택이 아닌 필수가 됐음을 의미한다.

#### Shopify의 발송 프로필 구성 항목

| 항목 | 내용 |
|------|------|
| Location (발송지) | 창고명, 주소(국가·도시·우편번호), 전화번호 |
| Location Group | 동일한 배송 조건을 공유하는 발송지 묶음 |
| Zone | 배송 가능 국가/지역 (예: 일본, 동남아, 미국 등) |
| Rate | Zone별 배송비 (고정·무료·무게 기반·캐리어 연동) |
| 상품 연결 | 어떤 상품이 이 프로필 적용 대상인지 |

#### Shopify의 한계

- 발송 프로필에 통관 정보(HS코드, 발송인 세관 번호 등)를 직접 저장하는 필드 없음
- 국제배송 통관은 서드파티 앱(Flexport, Zonos 등) 또는 캐리어 서비스 API로 별도 처리
- 크로스보더 규정 준수(관세·수입세)는 Shopify Markets + Duties and Import Taxes 기능으로 분리 제공

### 2.2 카페24

#### 구조 개요

카페24는 발송 프로필이라는 독립 개념을 두지 않는다. 대신 다음 구조로 운영된다:

```
쇼핑몰 설정
└── 배송 설정
    ├── 배송 업체 관리 (택배사 등록)
    │   └── 운송장 입력 시 선택 가능한 택배사 목록
    ├── 배송비 정책 (국내/해외 구분)
    │   ├── 무료/유료/조건부 무료
    │   └── 지역별 추가 배송비
    └── 해외 배송 설정
        ├── 지원 국가 선택
        ├── 해외 배송비 설정
        └── HS코드 (상품별 설정)
```

**핵심 특징**:
- 발송지는 사업자 정보(쇼핑몰 설정)에 1개만 등록. 복수 발송지 개념 없음
- 해외배송 활성화 시 EMS(우체국 연동) 또는 특송(DHL·FedEx) 선택
- HS코드는 배송 프로필이 아닌 **상품별로** 개별 설정 (상품 > 통관 정보)
- 일본 배송은 "글로벌 쇼핑몰"(별도 일본어 쇼핑몰 개설)과 연동 구조 — 단일 어드민에서 한국·일본 통합 관리가 되지 않음

**카페24의 한계**:
- 복수 발송지(창고) 관리 불가 — 한국 창고 외 일본 현지 창고 개념 없음
- 발송 위치별로 다른 택배사를 연결하는 구조 부재
- 국가별 판매 채널이 별도 쇼핑몰로 분리되어 있어 통합 재고·발송 관리가 어려움

### 2.3 Magento / Adobe Commerce

#### 구조 개요

Magento는 기본적으로 발송지 1개(Store Configuration의 Shipping Origin)만 설정할 수 있다. 복수 창고 관리는 **Multi-Source Inventory(MSI)** 기능으로 별도 제공된다.

```
Store Configuration
└── Shipping Settings
    └── Origin (단일 발송지: 국가·주소·우편번호)

Multi-Source Inventory (MSI, Adobe Commerce 기본 포함)
├── Source (재고 출처: 창고별 주소·재고 수량 관리)
└── Stock (복수 Source를 묶어 판매 채널에 할당)
```

**복수 발송지(Multi-Origin Shipping)**:
- 기본 Magento는 발송지 1개. 복수 발송지별 배송비 자동 계산은 기본 미지원
- **Calcurates, ShipperHQ** 같은 서드파티 확장을 통해 Origin별 배송비·택배사 매핑 구현
- Split Checkout 기능(복수 창고에서 분할 발송 시 배송비 합산 처리)도 확장으로 제공

**통관 정보 관리**:
- Magento 자체는 HS코드·통관 정보를 기본 필드로 제공하지 않음
- 국제배송 통관은 DHL eCommerce, FedEx 등 캐리어 확장에서 별도 처리

### 2.4 WooCommerce

```
Shipping Zones (배송 구역)
├── Zone (국가/지역 지정)
└── Methods (해당 구역에서 제공할 배송 방식·요금)

Custom Origins (플러그인 의존)
└── 구역별·방식별로 다른 발송지 설정 가능 (Octolize UPS 플러그인 등)
```

WooCommerce는 기본적으로 단일 발송지만 지원하고, 복수 발송지 관리는 플러그인(Calcurates Multi-Origin Shipping, WooCommerce Shipping Locations Pro 등)에 의존한다.

### 2.5 BigCommerce

BigCommerce는 **Store Location** 섹션에서 단일 창고 주소를 설정하며, Shipping Zones로 배송 가능 구역을 관리한다. Multi-Storefront 기능을 통해 스토어별로 별도 재고·배송 설정이 가능하지만, 단일 스토어 내 복수 발송지 관리는 ShipperHQ 같은 서드파티 연동이 필요하다.

### 2.6 경쟁사 비교 요약

| 플랫폼 | 복수 발송지 | 발송지별 택배사 매핑 | 통관 정보 내장 | 구현 방식 |
|--------|-----------|-------------------|-------------|---------|
| Shopify | ✅ (Locations) | ✅ (Delivery Profile) | ❌ (서드파티) | 네이티브 |
| 카페24 | ❌ | ❌ | △ (상품별 HS코드) | 제한적 |
| Magento | △ (MSI) | ❌ (확장 필요) | ❌ (확장 필요) | 확장 의존 |
| WooCommerce | ❌ (플러그인 의존) | ❌ (플러그인 의존) | ❌ | 플러그인 의존 |
| BigCommerce | ❌ (서드파티) | ❌ (서드파티) | ❌ | 서드파티 의존 |

**시사점**: Shopify만이 복수 발송지 + 발송지별 배송 조건 매핑을 네이티브로 구현했다. 카페24를 포함한 나머지는 이 기능이 없거나 확장에 의존한다. 누리메이트가 글로벌 SaaS를 표방한다면 Shopify 수준의 구조가 기준점이 되어야 한다.

---

## 3. 발송 프로필 정보 항목 정의

### 3.1 기본 정보

| 항목 | 필드명 | 설명 | 필수 여부 |
|------|--------|------|---------|
| 프로필명 | `name` | 셀러가 식별하기 위한 이름 (예: "한국 서울 창고", "일본 도쿄 3PL") | 필수 |
| 프로필 설명 | `description` | 내부 메모 | 선택 |
| 기본 프로필 여부 | `is_default` | 주문 생성 시 기본으로 선택되는 프로필 | 필수 |
| 활성화 여부 | `is_active` | 비활성화 시 주문 처리에서 제외 | 필수 |

### 3.2 출발 국가·주소 (창고/사업장)

| 항목 | 필드명 | 설명 | 필수 여부 |
|------|--------|------|---------|
| 출발 국가 | `origin_country` | ISO 3166-1 alpha-2 (KR, JP 등) | 필수 |
| 우편번호 | `origin_postal_code` | 국가별 형식 적용 | 필수 |
| 주 / 도 | `origin_state` | 도도부현, 시/도 등 | 선택 |
| 도시 | `origin_city` | | 필수 |
| 상세 주소 | `origin_address1` | | 필수 |
| 상세 주소 2 | `origin_address2` | | 선택 |
| 사업장명 | `origin_company` | 창고명 또는 3PL 업체명 | 선택 |
| 담당자명 | `origin_contact_name` | | 선택 |
| 담당자 연락처 | `origin_phone` | | 선택 |

### 3.3 이용 택배사

| 항목 | 필드명 | 설명 |
|------|--------|------|
| 지원 택배사 목록 | `carriers[]` | 이 프로필에서 사용 가능한 택배사 목록 |
| 기본 택배사 | `default_carrier` | 주문 생성 시 기본 선택 택배사 |
| 택배사 계약 코드 | `carrier_account_code` | 셀러의 택배사 계약 고객번호 (선택·B2B 계약 시) |

**한국 지원 택배사 (Phase 1)**:
- CJ대한통운 (`CJ_KOREA`)
- 한진택배 (`HANJIN`)
- 롯데택배 (`LOTTE`)
- 우체국택배 (`EPOST`)

**일본 지원 택배사 (Phase 3 — logistics-strategy.md 참조)**:
- 야마토 운수 (`YAMATO`)
- 사가와 급편 (`SAGAWA`)
- 일본우편 ゆうパック (`JAPAN_POST`)

### 3.4 배송 가능 국가·지역 범위

| 항목 | 필드명 | 설명 |
|------|--------|------|
| 배송 가능 국가 | `shipping_zones[]` | 이 프로필로 발송 가능한 국가/지역 목록 |
| 배송비 정책 연결 | `shipping_rate_policy_id` | 연결된 배송비 정책 (별도 배송비 설정 모듈과 연동) |
| 배송 불가 지역 | `excluded_zones[]` | 특정 지역 제외 (도서·산간 등) |

### 3.5 국제배송 통관 정보

국제배송(한국→일본 등 크로스보더)이 포함된 프로필에만 적용된다.

| 항목 | 필드명 | 설명 | 필수 여부 |
|------|--------|------|---------|
| 발송인 통관 번호 | `customs_sender_id` | 한국: 통관고유부호 / 일본: 법인 번호 등 | 국제배송 시 필수 |
| 발송인 사업자 등록번호 | `business_registration_no` | 수출신고 시 필요 | 국제배송 시 필수 |
| 기본 HS코드 | `default_hs_code` | 프로필 기본값 (상품별 HS코드로 오버라이드 가능) | 선택 |
| 원산지 | `country_of_origin` | 상품 기본 원산지 (Made in Korea 등) | 선택 |
| 세관 신고 통화 | `customs_currency` | 세관 신고 시 사용 통화 | 선택 |
| 통관 메모 | `customs_note` | 품목 특이사항 (식품·화장품 등 규제 품목 관련) | 선택 |

> **참고**: HS코드는 프로필 기본값을 설정하되, 상품별로 개별 오버라이드가 가능해야 한다. 카페24의 경우 HS코드를 상품별로만 관리하여 대량 상품 등록 시 반복 입력이 불편하다는 셀러 불만이 있다.

### 3.6 배송비 정책 연결

발송 프로필과 배송비 정책은 1:N 관계로 관리하는 것이 권장된다(Shopify 모델 참조).

```
ShippingProfile (1)
└── ShippingZoneGroup (N)
    ├── countries[] (배송 가능 국가 묶음)
    └── rates[] (해당 구역의 배송비 규칙)
        ├── flat_rate (고정 금액)
        ├── free_above (일정 금액 이상 무료)
        └── weight_based (중량 기반)
```

---

## 4. 다국가 운영 셀러를 위한 프로필 전환 UX

### 4.1 주문 생성 시 프로필 선택 플로우

```
주문 접수
    │
    ▼
발송 프로필 자동 매칭 시도
    ├── 상품의 재고 위치(창고) 확인
    ├── 구매자 배송지 국가 확인
    └── 매칭 조건: (재고 보유 창고) × (배송지 국가를 서비스하는 프로필)
    │
    ▼ (복수 프로필 매칭 시)
판매자에게 선택 요청
    ├── "이 주문은 아래 2개 발송 프로필로 처리 가능합니다"
    │   ├── [한국 서울 창고 — CJ대한통운 — 국제배송 3~5일]
    │   └── [일본 도쿄 창고 — 야마토 — 국내배송 1~2일]
    └── 선택 후 → 운송장 생성 + 배송비 확정
```

### 4.2 자동 선택 우선순위 규칙 (판매자 설정 가능)

1. 구매자 배송지와 동일 국가의 창고 우선
2. 배송비 최소화 우선
3. 배송 소요일 최단 우선
4. 재고 여유 큰 창고 우선 (재고 분산 방지)

---

## 5. 누리메이트 구현 우선순위 및 권장 사항

| 기능 | 우선순위 | 근거 |
|------|---------|------|
| 발송지 1개 (기본 설정) | **P0** | 소호 셀러·MVP 대상 필수. 모든 셀러에게 기본 발송지(주소·택배사 선택)는 반드시 있어야 함 |
| 발송 프로필 복수 등록 UI | **P1** | 중소 셀러 이상 대상. 6월 런칭 MVP에는 불필요하나 일본 진출 지원(Phase 3)에 선행 필요 |
| 한국 택배사 연동 (운송장 자동 생성) | **P1** | `logistics-strategy.md` Phase 2 항목. 운송장 입력은 P0, 자동 생성은 P1 |
| 배송 가능 국가·구역 설정 | **P1** | 글로벌 진출 기능(`spec/global-launch.md`)과 연동 시 필요 |
| 통관 정보 (HS코드 기본값, 통관 번호) | **P1** | 한국→일본 크로스보더 셀러 대상. 일본 진출 지원 기능 활성화 전 선행 |
| 발송 프로필 기반 배송비 자동 연동 | **P2** | 발송지별 배송비가 자동 계산되는 고급 기능. 초기에는 수동 입력으로 대체 가능 |
| 일본 택배사 연동 (야마토·사가와 API) | **P2** | `logistics-strategy.md` Phase 3 항목. 2026 H2~2027 일정 |
| 주문별 프로필 자동 매칭 엔진 | **P2** | 기업형 셀러 대상. 복수 프로필 보유 셀러가 다수 생긴 뒤 필요 |

### 5.1 MVP(P0) 최소 구현 범위

6월 런칭 시 발송 프로필과 관련하여 필요한 최소 기능:

1. **기본 발송지 설정**: 셀러 스토어에 발송지 주소(국가·주소·우편번호) 1개 등록
2. **택배사 선택**: 한국 택배사(CJ·한진·롯데·우체국) 중 선택
3. **운송장 번호 입력 + 배송 추적**: 어드민에서 운송장 번호 수기 입력 → 배송 추적 자동 연동

### 5.2 P1 구현 범위 (일본 진출 지원 전 선행)

1. **발송 프로필 복수 등록**: 창고별로 독립된 프로필 생성 (이름·주소·택배사 지정)
2. **통관 정보 입력**: 프로필별 통관고유부호, HS코드 기본값
3. **배송 가능 국가 지정**: 프로필별로 서비스 가능 국가 범위 설정

---

## 6. 결론 및 권장 방향

### 6.1 발송 프로필 기능은 필요하다 — 단, 단계적으로

- **소호 셀러(초기 타겟 고객)**에게 복수 프로필 기능은 MVP 단계에서 불필요하며 온보딩 복잡도만 높인다. 기본 발송지 1개 설정으로 충분하다.
- **중소·기업형 셀러**는 복수 발송지 관리, 택배사 연동, 통관 정보 입력이 반드시 필요하다. 이 규모 셀러가 누리메이트를 선택하려면 발송 프로필 기능의 완성도가 카페24 이상이어야 한다.
- 누리메이트의 핵심 차별화 포인트인 "일본 진출 지원"은 결국 한국 창고 발송 + 일본 통관을 하나의 플로우로 처리해야 하므로, **발송 프로필 구조 없이는 글로벌 진출 기능 자체가 불완전해진다**.

### 6.2 Shopify 모델을 기준으로 설계

Shopify의 Location + DeliveryProfile 분리 구조는 업계 표준으로 검증됐다. 누리메이트도 이 구조를 따르되 아시아 크로스보더에 특화된 필드(통관 번호, 한국·일본 택배사 직접 연동)를 추가하는 방향을 권장한다.

### 6.3 카페24 대비 명확한 개선 포인트

카페24는 발송 프로필 개념 자체가 없고, 한국 쇼핑몰과 일본 쇼핑몰을 별도로 운영해야 한다. 누리메이트가 단일 어드민에서 한국·일본 발송 프로필을 통합 관리하는 기능을 제공하면, 다국가 운영 셀러에게 카페24 대비 명확한 전환 유인이 된다.

### 6.4 권장 구현 로드맵

```
2026 Q2 (MVP 런칭)
└── P0: 기본 발송지 1개 + 택배사 선택 + 운송장 입력

2026 Q3 (일본 진출 지원 전)
└── P1: 발송 프로필 복수 등록
    P1: 프로필별 통관 정보 입력
    P1: 배송 가능 국가 설정

2026 H2 ~ 2027
└── P2: 일본 택배사 API 연동 (야마토·사가와)
    P2: 배송비 자동 계산 연동
    P2: 주문별 프로필 자동 매칭 엔진
```

---

## 출처

- [Shopify Help Center | Shipping profiles](https://help.shopify.com/en/manual/fulfillment/setup/shipping-profiles)
- [Shopify Help Center | Managing fulfillment locations in shipping profiles](https://help.shopify.com/en/manual/fulfillment/setup/shipping-profiles/managing-fulfillment-locations)
- [Shopify DeliveryProfile — GraphQL Admin API](https://shopify.dev/docs/api/admin-graphql/latest/objects/deliveryprofile)
- [Build delivery profiles — Shopify Dev](https://shopify.dev/docs/apps/build/purchase-options/deferred/delivery-and-deferment/build-delivery-profiles)
- [Shopify Update 2025: "Sell Only Within Configured Shipping Zones" — Klizer](https://www.klizer.com/blog/shopify-update-2025/)
- [How to handle Shopify shipping with Multiple Warehouses — PluginHive](https://www.pluginhive.com/knowledge-base/shopify-fedex-shipping-with-multiple-warehouses/)
- [Shipping settings | Adobe Commerce](https://experienceleague.adobe.com/en/docs/commerce-admin/stores-sales/delivery/shipping-settings)
- [Multi Origin Shipping for Magento — Calcurates](https://calcurates.com/features/magento-multi-origin-shipping)
- [카페24 간편해외배송 설정 — 카페24 Help Center](https://support.cafe24.com/hc/ko/articles/14114388048793)
- [카페24 HS코드란 무엇이고 어떻게 설정하나요? — 카페24 Help Center](https://support.cafe24.com/hc/ko/articles/8475772579993)
- [BigCommerce Shipping Zones — BigCommerce Help Center](https://support.bigcommerce.com/s/article/Shipping-Zones)
- [Cross-Border Ecommerce Made Easy — ShipStation](https://www.shipstation.com/blog/cross-border-ecommerce-made-easy-leveraging-technology-for-seamless-expansion/)
