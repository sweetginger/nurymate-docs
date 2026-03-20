# YouTube Shopping 지원 플랫폼 등록 절차 조사 [17-12]

> 작성일: 2026-03-18 | 관련 태스크: [17-12] | 상태: Draft

---

## 1. 프로그램 개요 및 셀러 혜택

### 1-1. YouTube Shopping이란

YouTube Shopping은 크리에이터가 영상·라이브 스트림·Shorts에 상품을 태그하여 시청자가 그 자리에서 구매까지 완결할 수 있도록 하는 소셜 커머스 기능이다. 2022년 미국 베타 출시 후 2023~2026년에 걸쳐 한국·일본을 포함한 아시아 주요 시장으로 빠르게 확대됐다.

**두 가지 참여 모델**

| 모델 | 대상 | 설명 |
|------|------|------|
| **YouTube Shopping (자체 스토어)** | 판매자 (브랜드·셀러) | Google Merchant Center에 상품 피드 연동 → 크리에이터 채널에 상품 노출 |
| **YouTube Shopping 제휴 프로그램 (Affiliate)** | 크리에이터 | 제휴 판매자 상품을 영상에 태그 → 구매 시 수수료 수익 |

누리메이트는 **"지원 플랫폼(Shopping Platform/Retailer)"** 지위 취득이 목표다. 지원 플랫폼이 되면 플랫폼 내 셀러들이 Google Merchant Center를 통해 YouTube Shopping에 연동할 수 있고, 누리메이트 내부에서 크리에이터 채널 연결을 직접 중개할 수 있다.

### 1-2. 지원 플랫폼이 셀러에게 제공하는 기능 범위

| 기능 | 설명 |
|------|------|
| **상품 피드 자동 동기화** | GMC(Google Merchant Center) ↔ 플랫폼 상품 DB 실시간 동기화 |
| **영상 상품 태그** | 일반 영상에 상품 카드 삽입 (최대 60개/영상) |
| **Shorts 상품 스티커** | Shorts에 클릭 가능한 상품 스티커 삽입 (2025년 주요 기능으로 강화) |
| **라이브 쇼핑** | 라이브 스트림 중 실시간 상품 태그 (최대 30개/방송) |
| **YouTube Store 개설** | 채널 내 전용 스토어 탭 운영 (카페24 모델: 결제까지 YouTube 내 완결) |
| **크리에이터↔셀러 매칭** | 셀러가 GMC 내에서 특정 채널에 상품을 독점 제공 가능 |
| **커미션 설정** | 셀러가 크리에이터별 수수료율·어트리뷰션 윈도우 직접 설정 (기본 30일) |
| **체크아웃** | 외부 스토어로 이동 또는 YouTube 내 체크아웃 (플랫폼 지원 시) |

---

## 2. 공식 지원 플랫폼 자격요건

### 2-1. 현재 공식 지원 플랫폼 현황

구글이 공식적으로 지원 통합을 제공하는 플랫폼은 다음과 같다.

| 플랫폼 | 비고 |
|--------|------|
| **Shopify** | YouTube 제휴 프로그램(Affiliate) 포함 전체 기능 지원 |
| **Cafe24** | 한국·글로벌 판매자 대상, YouTube Shopping Store 개설 기능 세계 최초 제공 (2024) |
| **Spring** | 크리에이터 머천다이즈 특화 |
| **Spreadshop** | 크리에이터 머천다이즈 특화 |
| **SHOPLINE** | YouTube Shopping 계정 연동 기능 제공 (아시아 중심) |

> ⚠️ 미확인: 퀸잇·컬리·오늘의집 등 국내 커머스 플랫폼의 공식 파트너 지위 여부. 이들은 셀러로 참여하는 것과 플랫폼 파트너로 참여하는 것이 다름.

### 2-2. Google Merchant Center 연동 요건

| 요건 | 상세 |
|------|------|
| GMC 계정 | 판매자(셀러) 단위로 GMC 계정 생성 또는 플랫폼이 Sub-account 구조로 일괄 관리 |
| 웹사이트 소유권 인증 | Google Search Console 또는 HTML 태그 방식으로 도메인 소유권 확인 |
| YouTube 채널 연결 | GMC → YouTube Studio에서 채널 연결 승인 (OAuth 기반) |
| 결제·배송·반품 정책 | 스토어 페이지에 명시 필수 |
| Google 쇼핑 정책 준수 | 허위 정보, 위험 상품, 저작권 침해 상품 불가 |

### 2-3. 상품 피드 포맷·품질 기준 (Google Shopping Feed 스펙)

**필수 속성**

| 속성명 | 설명 |
|--------|------|
| `id` | 고유 상품 ID |
| `title` | 상품명 (최대 150자) |
| `description` | 상품 설명 (최대 5,000자) |
| `link` | 상품 페이지 URL |
| `image_link` | 대표 이미지 URL |
| `price` | 가격 (통화 포함, 예: `29000 KRW`) |
| `availability` | `in stock` / `out of stock` / `preorder` |
| `condition` | `new` / `used` / `refurbished` |
| `brand` | 브랜드명 |
| `gtin` | 국제 표준 상품 코드 (EAN·UPC 등, 없는 경우 `identifier_exists: no`) |

**YouTube Shopping 전용 속성**

| 속성명 | 설명 |
|--------|------|
| `youtube_channel_id` | 상품을 노출할 특정 크리에이터 채널 ID. 복수 채널 지정 가능 (반복 필드). 미지정 시 전체 크리에이터에 공개 |

**피드 업로드 기준**

- 파일 형식: `.txt` / `.tsv` / `.xml` (최대 4 GB)
- 업데이트 주기: **매일 업데이트 권장**, 최소 30일에 1회
- 업로드 방식: Content API (Merchant API) 또는 파일 업로드

### 2-4. 플랫폼 측 API 구현 요건

신규 플랫폼이 YouTube Shopping 공식 통합을 구현하려면 다음 API 스택을 지원해야 한다.

| API | 용도 |
|-----|------|
| **Google Merchant Center API (구 Content API for Shopping)** | 상품 피드 CRUD, 계정 관리, 상태 조회 |
| **YouTube Data API v3** | 채널 정보 조회, 영상 상품 태그 관리 |
| **Google Analytics 4 API** | 구매 전환 추적 연동 |
| **OAuth 2.0** | 셀러 GMC 계정 ↔ YouTube 채널 연결 인증 |

---

## 3. 등록·심사 절차

### 3-1. 신청 경로 및 담당 팀

| 구분 | 내용 |
|------|------|
| **공식 신청 경로** | Google Merchant Center 온보딩 후, YouTube 담당자(YouTube Representative)를 통해 추가 온보딩 진행 |
| **YouTube 측 온보딩** | YouTube 파트너십 팀이 플랫폼 심사 및 추가 설정을 담당 |
| **초기 접촉 방법** | Google for Retail 파트너십 팀 또는 Google 영업팀 통해 의사 타진 |

> ⚠️ 미확인: 직접 셀프 서비스 신청 포털 존재 여부. 현재 공식 문서는 "YouTube 담당자에게 문의하라"고만 안내하며, Shopify·Cafe24 외 플랫폼은 별도 협의 절차를 거쳐야 함.

### 3-2. 단계별 온보딩 절차

```
1. Google Merchant Center 계정 생성
   └─ 판매자 정보, 도메인 소유권 인증, 배송·반품 정책 설정

2. 상품 피드 등록
   └─ Content API 또는 파일 업로드 방식으로 피드 제출
   └─ 피드 검수 통과 확인 (품질 기준 충족)

3. Google Analytics 4 연결
   └─ GMC ↔ GA4 계정 연결

4. YouTube 채널 연결
   └─ GMC 내에서 YouTube 채널 연결 요청
   └─ 채널 소유자가 YouTube Studio에서 승인

5. YouTube 파트너 팀 심사 (플랫폼 파트너 지위 신청 시)
   └─ API 구현 역량 검토
   └─ 플랫폼 내 셀러 피드 품질 기준 충족 확인
   └─ YouTube 스토어 정책 준수 확인

6. YouTube Studio에서 상품 관리 활성화
   └─ 영상/라이브/Shorts에 상품 태그 노출 시작
```

### 3-3. 심사 기간 및 갱신

| 항목 | 내용 |
|------|------|
| **GMC 계정 심사** | 통상 수일~2주 이내 |
| **플랫폼 파트너 심사** | ⚠️ 미확인 (Google 내부 협의 기간으로 공개 정보 없음. 카페24는 Google 투자 유치(259억 원, 2023년말)와 연계하여 긴밀한 파트너십 체결) |
| **피드 갱신** | 상품 정보 변경 시 즉시 반영 권장, GMC 정책상 30일 이내 재업로드 필수 |
| **정책 위반 시** | 계정 정지 또는 상품 비승인 (재심사 신청 가능) |

### 3-4. 기존 파트너 사례에서 확인된 절차 정보

**카페24 (Cafe24)**
- 2023년 말 Google로부터 259억 원 전략적 투자 유치 → YouTube Shopping 파트너십 공식화
- 2024년 세계 최초 'YouTube Shopping Store' 개설 기능 출시 (별도 플랫폼 이동 없이 YouTube 내 주문·결제 완결)
- GMC 플랫폼 내 전용 플로우를 통해 셀러가 특정 채널에 독점 상품 리스팅 가능

**Shopify**
- Google & YouTube 공식 앱을 Shopify App Store를 통해 설치
- Shopify Advanced 또는 Plus 플랜 + GMC 계정 + 자동 상품 동기화 활성화 필수
- 제휴 프로그램(Affiliate) 참여 조건: 미국 타겟 마켓 설정

---

## 4. 기술 구현 요건

### 4-1. 셀러 스토어 ↔ GMC 상품 피드 자동 동기화 구조

```
[누리메이트 상품 DB]
       │
       ▼ (상품 생성/수정/삭제 이벤트 트리거)
[피드 생성 서비스]
  - Google Shopping Feed 스펙에 맞는 XML/TSV 변환
  - youtube_channel_id 속성 포함
       │
       ▼
[Google Merchant Center API (Merchant API)]
  - products.insert / products.update / products.delete
  - 재고·가격 변경 → 즉시 반영 (webhooks 또는 polling)
       │
       ▼
[YouTube Shopping]
  - 크리에이터 YouTube Studio에서 승인된 상품 태그 가능
```

**핵심 동기화 요건**
- 재고 소진 시 `availability: out of stock` 즉시 업데이트 → 품절 상품 태그 방지
- 가격 변경 시 피드 즉시 반영 (지연 시 GMC 정책 위반 가능)
- 상품 삭제 시 GMC에서도 동기화 삭제

### 4-2. YouTube 채널 연결 OAuth 플로우

```
[셀러 (누리메이트 대시보드)]
       │
       ▼ "YouTube 채널 연결" 버튼 클릭
[누리메이트 백엔드]
  - Google OAuth 2.0 Authorization URL 생성
  - Scope: https://www.googleapis.com/auth/youtube.readonly
           https://www.googleapis.com/auth/content (GMC 관리용)
       │
       ▼ 리다이렉트
[Google OAuth 동의 화면]
  - 셀러가 Google 계정으로 로그인 + 권한 동의
       │
       ▼ Authorization Code 반환
[누리메이트 백엔드]
  - Access Token + Refresh Token 교환
  - GMC 계정 ID 및 YouTube 채널 ID 조회
  - 토큰 암호화 저장
       │
       ▼
[YouTube Studio 채널 연결 승인]
  - 셀러가 YouTube Studio에서 GMC 연결 승인
  (플랫폼 파트너는 셀러 대신 이 과정을 중개할 수 있음)
```

### 4-3. 주문·재고 실시간 반영 요건

| 요건 | 구현 방식 |
|------|----------|
| **재고 동기화** | 상품 재고 변경 이벤트 → Merchant API `products.update` 호출 (availability 필드 갱신) |
| **가격 동기화** | 가격 변경 시 즉시 피드 업데이트. 할인 가격은 `sale_price` + `sale_price_effective_date` 속성 활용 |
| **주문 추적** | GA4 전환 이벤트 + YouTube Shopping 어트리뷰션(기본 30일 쿠키) 연동 |
| **배송 상태** | ⚠️ 미확인: YouTube 내 배송 추적 연동 공식 지원 범위 불명확 |

### 4-4. 추가 기술 고려사항

- **멀티 셀러 구조**: 누리메이트처럼 다수 셀러를 관리하는 플랫폼은 GMC **Multi-Client Account (MCA)** 구조를 사용하여 플랫폼 GMC 계정 하위에 셀러별 서브 계정을 생성하는 방식 권장
- **피드 속도**: Merchant API 쿼터는 계정당 초당 최대 QPS 제한 있음 (대량 셀러 동기화 시 배치 처리 필요)
- **상품 승인률**: 피드 제출 후 GMC 자동 심사에서 10~30% 비율로 비승인될 수 있음. 이미지 품질·가격 불일치·정책 위반이 주요 원인

---

## 5. 국가별 지원 현황

### 5-1. YouTube Shopping 지원 국가 (2026년 3월 기준)

| 기능 | 지원 국가 |
|------|-----------|
| **YouTube Shopping 전체 기능 (영상 태그·라이브·Shorts)** | 미국, 한국, 인도네시아, 태국, 베트남, 말레이시아, 필리핀, 인도, 싱가포르, 브라질 |
| **YouTube Shopping 제휴 프로그램 (크리에이터 커미션)** | 위 10개국 동일 |
| **일본** | ⚠️ 별도 구조 — Rakuten Ichiba와의 파트너십으로 제한적 지원 (2026년 2월 공식 발표) |

> 주의: 위 국가 목록은 크리에이터 기준 지원 국가이며, 플랫폼 파트너 지원 국가 목록은 별도로 존재할 수 있음.

### 5-2. 한국 (대한민국)

| 항목 | 내용 |
|------|------|
| **지원 시기** | 2023년 6월 세계 최초 YouTube 공식 쇼핑 채널 런칭 (라이브 커머스) |
| **제휴 프로그램 출시** | 2024년 6월 Coupang 파트너십으로 크리에이터 제휴 프로그램 한국 론칭 (미국에 이어 세계 2번째) |
| **주요 파트너** | Coupang (쿠팡), Cafe24 |
| **지원 플랫폼** | Cafe24 (YouTube Shopping Store 개설 세계 최초), Shopify |
| **크리에이터 조건** | YPP 가입 + 구독자 10,000명+ + 한국 거주 |
| **특이사항** | YouTube Korea가 세계 최초로 공식 라이브 커머스 채널 운영 |

### 5-3. 일본

| 항목 | 내용 |
|------|------|
| **지원 현황** | 일반 YouTube Shopping 제휴 프로그램 공식 지원 국가 목록에 **미포함** (2026년 3월 기준) |
| **Rakuten 파트너십** | 2026년 2월 Rakuten Ichiba × Google 파트너십 공식 발표. Rakuten Ichiba가 일본 최초 YouTube Shopping 제휴 프로그램 참여 업체로 등록 |
| **작동 방식** | 영상에 "상품 보기" 버튼 → 상품명·가격 표시 → Rakuten Ichiba 상품 페이지로 이동 |
| **크리에이터 조건** | ⚠️ 미확인: 일본 크리에이터의 공식 제휴 프로그램 지원 여부 불명확. Rakuten 측 별도 크리에이터 프로그램으로 운영될 가능성 |
| **시사점** | 일본 시장에서의 YouTube Shopping 진입은 Rakuten과의 협의 또는 별도 Google Japan 파트너십이 필요할 수 있음 |

### 5-4. 기타 아시아 주요 시장

| 국가 | 지원 현황 | 주요 파트너 |
|------|-----------|------------|
| 인도네시아 | 지원 (2024년 추가) | Shopee |
| 인도 | 지원 (2024년 추가) | Flipkart, Myntra |
| 싱가포르 | 지원 | - |
| 대만 | ⚠️ 미확인 | - |

---

## 6. 누리메이트 준비 체크리스트

### P0 — 플랫폼 파트너 지위 신청을 위한 필수 선결 조건

| # | 항목 | 설명 |
|---|------|------|
| P0-1 | **Google Merchant Center MCA 구조 설계** | 누리메이트 마스터 GMC 계정 + 셀러별 서브 계정 구조 설계 및 구현 |
| P0-2 | **Google Shopping Feed 스펙 준수 상품 피드 생성** | 필수 속성 전체 포함, `youtube_channel_id` 지원, XML/TSV 출력 |
| P0-3 | **Merchant API (Content API) 연동 구현** | 상품 CRUD, 재고·가격 실시간 동기화 |
| P0-4 | **GMC 계정 생성 가이드 및 자동화** | 셀러 온보딩 시 GMC 서브 계정 자동 생성 플로우 |
| P0-5 | **Google OAuth 2.0 연동** | 셀러 Google 계정 인증 → GMC 연결 → YouTube 채널 연결 플로우 |

### P1 — 플랫폼 파트너 신청 및 핵심 셀러 기능

| # | 항목 | 설명 |
|---|------|------|
| P1-1 | **Google·YouTube 파트너십 팀 접촉** | Google for Retail 또는 Google Korea 파트너십 팀에 플랫폼 파트너 의사 타진 |
| P1-2 | **YouTube 채널 연결 UX 구현** | 셀러 대시보드 내 "YouTube 채널 연결" 기능 (OAuth 플로우) |
| P1-3 | **크리에이터 채널별 독점 상품 지정 기능** | GMC 피드 내 `youtube_channel_id` 속성 설정 UI |
| P1-4 | **커미션 설정 기능** | 셀러가 크리에이터별 수수료율 및 어트리뷰션 윈도우 설정 |
| P1-5 | **GA4 전환 추적 연동** | YouTube Shopping 유입 → 구매 전환 추적 |
| P1-6 | **피드 품질 모니터링** | GMC 비승인 상품 알림 및 원클릭 수정 가이드 제공 |

### P2 — 차별화 및 고도화 기능

| # | 항목 | 설명 |
|---|------|------|
| P2-1 | **YouTube Shopping Store 개설 지원** | 카페24처럼 YouTube 내 결제 완결 스토어 개설 기능 (YouTube 측 추가 협의 필요) |
| P2-2 | **일본 Rakuten 파트너십 리서치** | 누리메이트 일본 셀러의 YouTube Shopping 진입 경로로 Rakuten 제휴 가능성 조사 |
| P2-3 | **AI 상품 태그 자동화 대응** | 2025년 YouTube가 도입한 AI 자동 태깅 기능과의 연동 최적화 |
| P2-4 | **QR코드 쇼핑 지원** | YouTube TV/모바일 크로스 디바이스 QR 코드 쇼핑 경험 지원 |
| P2-5 | **크리에이터 성과 대시보드** | 셀러 대시보드에서 채널별 노출·클릭·전환 수치 통합 조회 |

---

## 7. 결론 및 권고

### 현황 요약

YouTube Shopping은 한국 시장에서 이미 성숙 단계에 진입했다. 카페24가 259억 원 Google 투자와 함께 세계 최초 YouTube Shopping Store 기능을 출시했고, 쿠팡이 한국 제휴 프로그램 론칭 파트너로 참여했다. 일본 시장은 2026년 2월 Rakuten Ichiba와의 파트너십으로 YouTube Shopping이 본격 개시됐으나, 아직 일반 크리에이터 제휴 프로그램은 지원국 목록 외다.

### 누리메이트의 전략적 포지션

1. **단기 (2026 Q2-Q3)**: 카페24·Shopify 수준의 GMC 연동 기반 구현 완료 후 Google 파트너십 팀에 공식 접촉. 기술 역량(Merchant API, OAuth, 피드 품질) 사전 확보가 협상력의 핵심.

2. **중기 (2026 Q4)**: 한국 YouTube Shopping 공식 지원 플랫폼 등록. 셀러에게 "YouTube 채널 원클릭 연결" UX 제공 → 카페24 대비 차별화 포인트.

3. **장기 (2027+)**: 일본 시장 진입 시 Rakuten 파트너십 또는 별도 Google Japan 협의를 통해 일본 YouTube Shopping 연동. Shopify가 일본에서 약한 로컬 생태계 연동(Rakuten, LINE)을 누리메이트가 커버하는 전략.

### 핵심 리스크

| 리스크 | 내용 | 대응 |
|--------|------|------|
| **파트너십 심사 불투명성** | Google은 플랫폼 파트너 심사 기준·기간을 공개하지 않음 | 조기 접촉, Google Ads/Merchant Center 공식 파트너 먼저 취득 후 협상 레버리지 확보 |
| **카페24 선점 효과** | 카페24가 YouTube Shopping 기능에서 한국 시장 1위 파트너 | 일본 시장 등 카페24 비진출 영역에서 먼저 파트너십 확보 |
| **일본 YouTube Shopping 불확실성** | 일본은 Rakuten 통해서만 진입 가능한 구조일 수 있음 | Rakuten API 연동 또는 Google Japan과 별도 협의 채널 마련 |

---

## 출처

- [YouTube Shopping affiliate program overview & eligibility — YouTube Help](https://support.google.com/youtube/answer/13376398)
- [Get started with Shopping on YouTube — YouTube Help](https://support.google.com/youtube/answer/12257682)
- [About YouTube store data sources — Google Merchant Center Help](https://support.google.com/merchants/answer/12375531)
- [Get your products started with YouTube store — Google Merchant Center Help](https://support.google.com/merchants/answer/12362804)
- [Get started with the YouTube Shopping affiliate program (for Shopify merchants) — Google Merchant Center Help](https://support.google.com/merchants/answer/13773425)
- [About the YouTube Shopping affiliate program — Google Merchant Center Help](https://support.google.com/merchants/answer/14815513)
- [Shopify, YouTube expand partnership — Retail Dive](https://www.retaildive.com/news/shopify-youtube-expand-partnership/724954/)
- [Cafe24, 'emergency' on YouTube...now performance increases with 'live commerce' — TopDaily](https://en.topdaily.kr/articles/1424)
- [Cafe 24 attracted 26 billion investment from Google — AlphaBiz](https://alphabiz.co.kr/news/view/1065549198014419)
- [YouTube expands shopping features in South Korea — PrameYa News](https://www.prameyanews.com/youtube-expands-shopping-features-in-south-korea)
- [YouTube, Coupang offer Shopping affiliate program in Korea — KED Global](https://www.kedglobal.com/e-commerce/newsView/ked202406050016)
- [YouTube Korea to launch first official shopping channel — Korea Times](https://www.koreatimes.co.kr/amp/business/companies/20230621/youtube-korea-to-launch-first-official-shopping-channel-in-world)
- [Rakuten Ichiba Partners with Google to Offer Seamless Shopping Experiences via YouTube — Rakuten Group](https://global.rakuten.com/corp/news/press/2026/0219_01.html)
- [Rakuten × YouTube Shopping in Japan (2026) — Krows Digital](https://krows-digital.com/rakuten-youtube-shopping-japan-2026/)
- [Google, Rakuten to provide new shopping service in Japan on YouTube — Japan Today](https://japantoday.com/category/tech/google-rakuten-to-provide-new-shopping-service-in-japan-on-youtube)
- [YouTube Shopping Account Linking — SHOPLINE Help Center](https://support.shoplineapp.com/hc/en-us/articles/24191989236377-YouTube-Shopping-Account-Linking)
- [Feedonomics partners with YouTube to support Shopping affiliate program — PRNewswire](https://www.prnewswire.com/news-releases/feedonomics-partners-with-youtube-to-support-its-shopping-affiliate-program-302277146.html)
- [Product data specification — Google Merchant Center Help](https://support.google.com/merchants/answer/7052112)
- [2026 Guide to YouTube Shopping — Metricool](https://metricool.com/youtube-shopping/)
- [How YouTube Shopping Works for Ecommerce Businesses In 2025 — Shipfusion](https://www.shipfusion.com/blog/youtube-shopping)
