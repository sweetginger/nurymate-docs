# Shopify 일본 결제 UX 불편함 조사 — komoju 중심

## 조사 목적

일본 시장에서 Shopify를 운영하는 판매자가 현지 결제 수단(콘비니, 은행이체, PayPay, Rakuten Pay 등)을 지원하기 위해 거쳐야 하는 komoju 연동 과정의 복잡도와 구조적 문제를 분석한다. 이를 통해 누리메이트가 "일본 결제 네이티브 지원"을 핵심 차별화 포인트로 설정할 근거를 마련한다.

---

## 1. komoju 설치·설정 단계 분석

### 1-1. 전체 플로우 개요

Shopify 일본 판매자가 콘비니 결제 등 로컬 결제 수단을 활성화하려면 Shopify 기본 기능만으로는 불가능하다. komoju 앱을 별도로 연동해야 하며, 전체 프로세스는 아래와 같다.

### 1-2. 단계별 설치 절차 (공식 문서 기준)

| 단계 | 작업 내용 | 소요 시간 |
|------|----------|---------|
| 1 | komoju 공식 사이트에서 머천트 계정 신규 신청 | 10~20분 |
| 2 | 심사 통과 후 테스트(Test) 환경 접근 권한 부여 | 2~3 영업일 대기 |
| 3 | Shopify 관리자 → 결제 → 대체 결제 수단(Alternative Payment Methods) → "결제 공급업체 선택" 진입 | 5분 |
| 4 | 검색창에서 "KOMOJU" 검색 후 원하는 결제 수단별 앱 선택 (콘비니, 은행이체, PayPay 등 개별 앱 분리) | 10~20분 |
| 5 | komoju 대시보드에서 Merchant UUID와 Secret Key 복사 | 5분 |
| 6 | Shopify 결제 설정 화면에 UUID·Secret Key 입력 후 저장 | 5분 |
| 7 | 라이브 모드 신청: komoju 대시보드에서 "Go Live!" 버튼 클릭 후 추가 서류 제출 | 15~30분 |
| 8 | komoju 라이브 심사 완료 후 Shopify 결제 설정을 Test → Live 모드로 재전환 | 5~10분 |
| **합계** | **계정 생성부터 실사용까지** | **최소 3~5 영업일 + 수작업 1~2시간** |

### 1-3. 결제 수단별 앱 분리 문제

komoju는 Shopify App Store에서 결제 수단별로 **앱을 분리 제공**한다:

- KOMOJU ‑ Konbini Payments (콘비니 전용)
- KOMOJU ‑ Bank Transfer Japan (은행이체 전용)
- KOMOJU ‑ eNETS 등

즉, 콘비니 + 은행이체 + PayPay를 모두 지원하려면 각 앱을 개별 설치하거나, komoju 통합 페이지에서 결제 수단을 따로 선택해야 한다. 이는 관리 포인트 증가로 이어진다.

### 1-4. 해외 사업자 제한 사항

- **해외 법인(일본 법인 없음)** 판매자는 은행이체·Pay-easy·콘비니만 신청 가능하며, 스마트폰 결제(PayPay 등)는 일본 법인 보유 시에만 허용
- **세븐일레븐 규정**에 따라 일본 법인이 없는 사업자는 콘비니 결제 중 세븐일레븐 수납을 제공할 수 없음
- 신용카드 결제 승인은 최소 3 영업일 소요

---

## 2. Shopify Payments + komoju 병행 시 구조적 문제

### 2-1. 이중 수수료 구조

Shopify 일본에서 Shopify Payments와 komoju를 동시에 사용할 경우 수수료 이중 발생 구조가 형성된다:

| 결제 경로 | 발생 수수료 |
|---------|-----------|
| Shopify Payments (신용카드, Shop Pay 등) | 결제 수수료 2.90~3.90% (카드 종류별) / Shopify 거래 수수료 없음 |
| komoju (콘비니, 은행이체 등 대체 결제) | komoju 결제 수수료 2.75~3.85% + **Shopify 외부 거래 수수료 0.2~2.0%** (플랜별) |

핵심 문제: komoju 같은 **서드파티 결제 게이트웨이**를 사용하는 경우 Shopify는 **베이직 플랜 2%, 스탠다드 플랜 1%, 어드밴스드 플랜 0.5%의 외부 거래 수수료**를 별도 부과한다. 즉 komoju 수수료(약 3%) + Shopify 외부 수수료(최대 2%) = 실질 부담 최대 **5%**에 달할 수 있다.

### 2-2. 정산 분리 문제

- Shopify Payments를 통한 결제는 Shopify가 직접 정산하여 판매자 계좌로 입금
- komoju를 통한 결제(콘비니, 은행이체 등)는 komoju가 별도 정산: 월 정산(전월 거래를 말일 입금) 또는 주 정산(금요일 입금) 중 선택
- 결과적으로 판매자는 **Shopify Payments 정산 + komoju 정산 2개의 정산 사이클**을 동시에 관리해야 함
- 두 시스템의 정산 주기·보고서 형식이 달라 **매출 대사(reconciliation) 작업 복잡도** 증가

### 2-3. 관리 포인트 증가

| 관리 항목 | Shopify Payments | komoju |
|---------|----------------|--------|
| 대시보드 | Shopify 관리자 | komoju 별도 대시보드 |
| 정산 보고서 | Shopify Finance | komoju Settlement Notices |
| 환불 처리 | Shopify에서 직접 처리 | 콘비니 결제 환불 시 komoju 은행이체로 처리, **건당 ¥1,500 수수료** 부과 |
| 분석/추적 | Shopify Analytics 통합 | komoju 콘비니 결제는 **Google Analytics 전환 추적 미지원** |
| 결제 금액 표시 | Shopify 기본 표시 | 콘비니 결제 수수료가 Shopify 주문 금액 화면·이메일에 **기본 미표시** (별도 설정 필요) |

---

## 3. Shopify 일본 로컬 결제 미지원 배경

### 3-1. 기술·규제적 이유

- **결제 수단 다양성**: 일본은 콘비니 결제(세븐일레븐, 로손, 패밀리마트 각각 개별 계약 필요), Pay-easy, 은행이체, QR 결제(PayPay·Rakuten Pay), 후불(Paidy), 전자머니(Suica·Edy) 등 수십 가지 로컬 결제 수단이 혼재. 이를 단일 플랫폼에서 직접 통합하면 각 사업자와의 개별 계약 및 일본 결제업법(자금결제법) 준수 의무가 발생
- **현지 법인 요건**: 일본 주요 결제 수단 계약에는 일본 법인(또는 일본 내 은행 계좌) 보유가 조건으로 요구되는 경우가 많아, 글로벌 플랫폼인 Shopify가 직접 모든 수단을 커버하는 데 한계
- **AWS Japan 종료 사례**: Shopify는 2025년 1월 6일부로 일본 판매자 대상 Amazon Pay 지원을 종료했으며, 이후 Shop Pay·Apple Pay·Google Pay 등 글로벌 결제 수단으로 유도 중 — 로컬 결제 직접 통합보다 서드파티 파트너십 모델을 선호하는 기조

### 3-2. 사업적 이유

- Shopify의 수익 모델 관점에서 **서드파티 게이트웨이 사용 시 거래 수수료(0.5~2%)를 추가 징수**하는 구조가 오히려 유리
- Shopify Payments를 사용하면 외부 거래 수수료가 없어지므로, 로컬 결제 수단이 Shopify Payments에 통합되면 이 수수료 수익이 사라짐
- 일본 로컬 결제 시장은 글로벌 볼륨 대비 크지 않아 자체 개발 ROI가 낮다고 판단한 것으로 추정

---

## 4. 실제 판매자 불만 사례

### 4-1. 운영상 주요 불편 사항 (공개 문서·포럼 기반)

**결제 수수료 부담**
- Shopify 커뮤니티 포럼에 따르면, 베이직 플랜 판매자는 서드파티 게이트웨이 사용 시 Shopify 거래 수수료 2%가 추가 발생한다는 점에서 "왜 이중으로 내야 하나"라는 불만이 반복적으로 제기됨
- "Shopify 플랜을 올리지 않으면 서드파티 수수료 폭탄을 맞는다"는 구조적 비용 불만

**콘비니 결제 UX 문제**
- 콘비니 결제 수수료가 Shopify 주문 확인 화면과 이메일에 기본으로 표시되지 않아, 고객이 실제 납부 금액을 혼동하는 사례 발생 → 별도 커스터마이징 필요
- 콘비니 결제는 고객이 별도 결제 번호를 발급받아 편의점에서 직접 현금 납부하는 구조로, 최대 3일 결제 유예기간 동안 재고가 묶이는 문제

**환불 복잡도**
- 콘비니 결제 환불은 카드 결제처럼 자동 처리가 불가능하며, komoju가 고객 계좌로 직접 은행이체 처리 → 건당 **¥1,500 환불 수수료** 발생
- 환불 처리 기간도 수일~수 주 소요되어 고객 불만 발생

**Google Analytics 추적 불가**
- 콘비니 결제를 선택한 주문에 대해 Google Analytics 전환 이벤트 추적이 지원되지 않아, 마케팅 성과 분석에 맹점 발생

**해외 셀러의 기능 제한**
- 일본 법인 없이 Shopify Japan에서 판매하는 한국·해외 셀러는 PayPay·Rakuten Pay 등 QR 결제 수단 연동 자체가 불가능 — 일본 소비자의 주요 결제 수단에 접근하지 못하는 구조적 장벽

### 4-2. komoju 자체 불편 사항

- 심사 기간(최소 2~3 영업일) 동안 라이브 결제 불가 → 긴급 출시 시 병목
- 결제 수단별 앱 분리로 관리 복잡도 증가 (콘비니·은행이체·PayPay 각각 별도 설정)
- komoju 대시보드와 Shopify 대시보드가 분리되어 있어 단일 화면에서 전체 매출 파악이 어려움

---

## 5. 경쟁 일본 결제 앱 비교

### 5-1. 주요 앱별 비교

| 항목 | komoju | Paidy | GMO Payment Gateway | Shopify Payments |
|------|--------|-------|---------------------|-----------------|
| 지원 결제 수단 | 콘비니, 은행이체, 신용카드, PayPay, LINE Pay, Merpay, 전자머니 등 다수 | 후불(BNPL), 분할 결제 전문 | 신용카드, 콘비니, 은행이체, 스마트폰 결제 | 신용카드(Visa/MC/AmEx/JCB), Shop Pay, Apple Pay, Google Pay |
| 일본 법인 요구 | 일부 결제 수단 (PayPay 등) | 불요 | 일본 법인 권장 | 불요 |
| Shopify 외부 수수료 적용 | 있음 (0.5~2%) | 있음 (0.5~2%) | 있음 (0.5~2%) | 없음 |
| 결제 수수료 | 2.75~3.85% | 머천트 수수료 별도 협의 | 카테고리·계약별 상이 | 2.90~3.90% |
| 환불 처리 | 콘비니 환불 건당 ¥1,500 | 자동 처리 지원 | 자동 처리 지원 | 자동 처리 지원 |
| 정산 주기 | 월/주 선택 | 월 정산 | 월 정산 | Shopify Payments에 통합 |
| 설정 복잡도 | 중간 (앱 분리, 2~3일 심사) | 낮음 (설치 후 즉시) | 높음 (계약·API 연동 필요) | 낮음 (Shopify 내장) |
| 콘비니 결제 | 지원 (세부 편의점 선택 가능) | 미지원 | 지원 | 미지원 |
| GA 전환 추적 | 콘비니 결제는 미지원 | 지원 | 지원 | 지원 |
| Shopify App Store | 있음 (공식 앱) | 있음 | 별도 연동 필요 | 기본 탑재 |

### 5-2. 결제 수단별 커버리지

일본 Shopify 판매자가 "모든 주요 결제 수단"을 커버하려면 단일 앱으로는 부족하다:

- Shopify Payments → 신용카드 커버
- komoju → 콘비니·은행이체·PayPay 커버
- Paidy → BNPL(후불) 커버

최소 2~3개 앱을 병행해야 일본 소비자의 90% 이상을 커버하는 결제 환경을 구성할 수 있으며, 각 앱의 정산·보고서·수수료 구조가 모두 다르다.

---

## 6. 누리메이트 기회 분석

### 6-1. 페인포인트 요약

| 페인포인트 | 규모 | 누리메이트 기회 |
|----------|------|--------------|
| 복잡한 결제 설정 (2~5일, 수작업) | 일본 내 Shopify 판매자 18,000개+ (도쿄 단일) | 설정 마법사 1단계 통합 |
| 이중 수수료 (Shopify 외부 수수료 최대 2% + 결제 수수료) | 베이직 플랜 판매자 직접 영향 | 단일 수수료 구조 |
| 정산 분리 (Shopify + komoju 이원화) | 전체 로컬 결제 사용 판매자 | 통합 정산·대사 리포트 |
| 환불 복잡도 (콘비니 건당 ¥1,500) | 콘비니 결제 활성화 판매자 | 자동 환불 처리 |
| GA 추적 불가 (콘비니 결제) | 퍼포먼스 마케팅 운영 판매자 | 기본 추적 통합 |
| 해외 셀러 로컬 결제 진입 장벽 (법인 요건) | 한국→일본 진출 셀러 | 법인 없이 PayPay 연동 경로 제공 |

### 6-2. 포지셔닝 제안

"Shopify Japan + komoju 조합의 복잡도 전부를 누리메이트 하나로 해결"

- **일본 결제 네이티브 지원**: 콘비니·은행이체·PayPay·Rakuten Pay를 별도 앱 없이 기본 탑재
- **단일 정산 대시보드**: 모든 결제 수단의 정산·보고서를 한 화면에서 관리
- **해외 셀러 패스트트랙**: 일본 법인 없는 한국 셀러가 QR 결제까지 연동할 수 있는 구조 설계
- **투명한 단일 수수료**: Shopify의 외부 거래 수수료 0.5~2% 추가 없는 플랫 수수료 체계

---

## 참고 출처

- [How to integrate Komoju on Shopify — KOMOJU](https://en.komoju.com/help/152-how-to-integrate-komoju-on-shopify/)
- [Integrating KOMOJU to Shopify — KOMOJU](https://en.komoju.com/help/520-integrating-komoju-to-shopify/)
- [Shopify Integration in Japan in 2025 — KOMOJU](https://en.komoju.com/blog/general-advice/shopify-integration-in-japan/)
- [Use KOMOJU to add Japanese and Korean payments to Shopify — KOMOJU](https://en.komoju.com/integrations/shopify/)
- [Shopify Payments for Japan — Shopify Help Center](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries/japan)
- [Shopify's payment methods in Japan — Shopify Japan Blog](https://www.shopify.com/jp/blog/payments-list-en)
- [Third-party transaction fees on your Shopify bills — Shopify Help Center](https://help.shopify.com/en/manual/your-account/manage-billing/billing-charges/types-of-charges/third-party-charges/third-party-transaction-fees)
- [Why does Shopify charge a 2% transaction fee for third-party providers? — Shopify Community](https://community.shopify.com/t/why-does-shopify-charge-a-2-transaction-fee-for-third-party-providers/246613)
- [How to add convenience store payments to Shopify using KOMOJU — Commerce Media](https://commerce-media.info/en/blogs/ec/shopify_komoju)
- [About KOMOJU Usage Fees and Settlement Fees — KOMOJU Help Center](https://help.komoju.com/hc/en-us/articles/4747472702622-About-KOMOJU-Usage-Fees-and-Settlement-Fees)
- [How to Receive Sales Proceeds and Issue Settlement Notices — KOMOJU Help Center](https://help.komoju.com/hc/en-us/articles/4747504540574-How-to-Receive-Sales-Proceeds-and-Issue-Settlement-Notices)
- [KOMOJU ‑ Konbini Payments — Shopify App Store](https://apps.shopify.com/komoju-1)
- [KOMOJU ‑ Bank Transfer Japan — Shopify App Store](https://apps.shopify.com/komoju-3)
- [Shopify + PayPay: Japan Merchant Payment Guide — CartDNA](https://www.cartdna.com/shopify-payment-methods/paypay)
- [Shopify + Konbini: Japanese Merchant Payment Guide — CartDNA](https://www.cartdna.com/shopify-payment-methods/konbini)
- [Shopify + Rakuten Pay: Japan Merchant Payment Guide — CartDNA](https://www.cartdna.com/shopify-payment-methods/rakuten-pay)
- [Which Shopify features are not available in Japan? — flagshipblog / Medium](https://medium.com/flagshipblog/which-shopify-features-are-not-available-in-japan-yet-c160452259f8)
- [PAYMENT METHODS IN THE JAPANESE E-COMMERCE ECOSYSTEM — flagshipblog / Medium](https://medium.com/flagshipblog/payment-methods-in-the-japanese-e-commerce-ecosystem-58a223d76dcc)
- [Shopify to End Amazon Pay for Japanese Merchants by January 2025 — Forest Shipping](https://www.forestshipping.com/shopify-to-end-amazon-pay-japanese-merchants-January-2025)
- [Japan Buy Now Pay Later Market Report 2025 — GlobeNewswire](https://www.globenewswire.com/news-release/2025/02/14/3026471/0/en/Japan-Buy-Now-Pay-Later-Market-Report-2025-Competitive-Landscape-and-Regulatory-Developments-in-Japan-s-BNPL-Market-A-58-34-Billion-Market-by-2030.html)
- [What payment services can be used in SHOPIFY in Japan? — GO RIDE](https://goriderep.com/en/blogs/news/what-payment-services-can-be-used-in-shopify-in-japan)
- [KOMOJU Software Pricing & Reviews — Capterra](https://www.capterra.com/p/300008/KOMOJU/)
- [Shopify Japan Expansion Guide 2026 — noren Inc.](https://noren-inc.co.jp/blogs/guide-to-japan/the-complete-guide-to-launching-your-shopify-store-in-japan-2026)
