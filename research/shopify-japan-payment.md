# [4-1] Shopify 일본 결제 구조 미지원 여부 검증

## 조사 결과

### 일본의 특유 결제 수단 개요

일본 이커머스 시장에는 글로벌 표준과 다른 독자적인 결제 수단들이 광범위하게 사용된다. 주요 결제 수단은 다음과 같다.

- **콘비니 결제 (コンビニ払い)**: FamilyMart, Lawson, Ministop, Seicomart 등 편의점에서 현금으로 결제. 온라인에서 주문 후 결제 코드를 받아 편의점을 방문해 납부하는 방식
- **후불 결제 (あと払い / 後払い)**: Paidy가 대표적. 주문 먼저 하고 나중에 결제하는 BNPL(Buy Now Pay Later) 방식
- **은행 자동이체 (口座振替)**: 은행 계좌에서 자동으로 금액이 인출되는 방식. 일본 구독형 서비스나 정기결제에 광범위하게 사용
- **착불 결제 (代金引換, 代引き)**: 택배 수령 시 배달원에게 현금으로 직접 결제하는 방식. 일본에서는 아직도 신뢰도 높은 결제 수단

### Shopify Payments 네이티브 지원 범위

Shopify Payments가 일본에서 네이티브로 지원하는 결제 수단은 **글로벌 범용 수단에 한정**된다.

- Visa, Mastercard, American Express, JCB (신용카드)
- Apple Pay, Google Pay
- PayPal

**PayPay, Rakuten Pay, 콘비니 결제, 은행이체(Pay-easy), Paidy 등 일본 특유 결제 수단은 Shopify Payments에서 네이티브로 지원하지 않는다.**

### 서드파티 앱/플러그인 의존 구조

일본 시장 특유 결제를 지원하기 위해서는 **KOMOJU**와 같은 제3자 결제 게이트웨이를 Shopify에 연동해야 한다.

KOMOJU는 다음을 지원한다.
- 콘비니 결제 (편의점 결제)
- Pay-easy (은행/ATM 결제)
- Paidy (후불결제)
- PayPay, LINE Pay, Rakuten Pay, Merpay, au PAY, d Payment
- 신용카드, 캐리어 빌링

KOMOJU 외에도 Paidy 자체 플러그인, GMO Payment Gateway 등 다수의 서드파티를 별도로 연동해야 한다.

### 代金引換 (착불 결제) 의 특수한 문제

Shopify는 착불 결제(代金引換)를 네이티브로 지원하지 않는다. 일본 판매자들이 이를 설정하려면 다음 방법에 의존해야 한다.

1. **수동 결제(Manual Payment)로 등록**: Shopify 관리자 화면에서 "Cash on Delivery"로 수동 추가 가능하지만 자동화가 불가능
2. **COD 수수료 자동 부과 불가**: Shopify 자체에는 COD 선택 시 수수료를 자동으로 추가하는 기능이 없어 서드파티 앱(Releasit COD 등) 필요
3. **배송사 연동 문제**: 일본 물류사(야마토운수, 佐川急便 등)의 착불 시스템과 Shopify가 직접 연동되지 않아 별도 WMS/OMS 시스템이 필요

### 일본 판매자들의 실제 불편 사례

1. **결제 수단 파편화**: 일본 소비자가 기대하는 결제 수단 전체를 커버하려면 KOMOJU + Paidy + PayPay 등 복수 앱을 중복 설치해야 하며, 각각 별도 계약과 수수료가 발생
2. **POS 결제 불가**: Shopify Payments는 일본에서 온라인 결제만 지원하며, 대면 POS 결제에는 사용 불가. 오프라인 매장 병행 운영 시 별도 단말기 계약 필요
3. **콘비니 결제 미도입 시 매출 손실**: 콘비니 결제 도입 시 매출이 15~25% 상승하는 효과가 있는 것으로 추정됨. 이는 신용카드 보급률이 낮고 현금 선호 문화가 강한 일본의 특성에서 기인
4. **구독/정기결제 문제**: 口座振替(은행 자동이체)가 표준인 구독 서비스 분야에서 Shopify의 기본 구독 기능은 이를 지원하지 않아 별도 구축 필요
5. **세금 표시 문제**: 일본 소비세법상 세금 포함 가격(税込価格) 표시가 의무이나, Shopify 기본 설정에서 이를 올바르게 처리하는 데 별도 설정이 필요

### 시장 규모 및 기회

- 일본 이커머스 시장 규모: 2025년 기준 약 $194.4억 (1940억 달러)
- 모바일 트래픽 비중: 전체 이커머스 트래픽의 70% 이상이 모바일에서 발생
- 콘비니 결제가 중요한 이유: 일본 신용카드 보급률이 낮고 현금 결제 선호도가 높아, 편의점 결제 미지원 시 실질적인 구매 장벽으로 작용

---

## 결론

Shopify는 일본 시장의 핵심 결제 수단(콘비니 결제, 着払い, 口座振替, 後払い)을 네이티브로 지원하지 않으며, 일본 판매자들은 KOMOJU 등 서드파티 앱 의존이 필수적이다. 이로 인해 복수 앱 계약·유지 비용, 설정 복잡도, 수수료 중복 등의 문제가 발생하며, 이는 "글로벌 이커머스 플랫폼의 일본 현지화 미흡"이라는 대표적인 사례가 된다. 착불(代金引換) 수수료 자동 부과 불가 등 운영 자동화의 한계도 일본 상인에게 실질적 부담으로 작용한다.

---

## 근거

- Shopify Payments Japan 공식 문서: 네이티브 지원 결제 수단 목록 확인 (신용카드, Apple Pay, Google Pay, PayPal)
- KOMOJU: Shopify 일본 결제 통합 솔루션으로 콘비니·PAY-EASY·후불 등 지원
- 콘비니 결제 도입 시 매출 15~25% 상승 효과 (KOMOJU/CartDNA 리포트)
- 着払い(COD) 설정 시 Shopify 수동 결제 등록 방식 의존 (Shopify 커뮤니티 문서)
- 일본 이커머스 모바일 트래픽 비중 70% 이상 (Praella 2025 리포트)
- 일본 이커머스 시장 규모 $194.4B (2025년 기준)

---

## 출처

- [Shopify Integration in Japan in 2025 - KOMOJU](https://en.komoju.com/blog/general-advice/shopify-integration-in-japan/)
- [Shopify + Konbini: Japanese Merchant Payment Guide - CartDNA](https://www.cartdna.com/shopify-payment-methods/konbini)
- [Shopify Payment Methods in Japan - CartDNA](https://www.cartdna.com/shopify-payment-guide/asia-east/japan)
- [KOMOJU Konbini Payments - Shopify App Store](https://apps.shopify.com/komoju-1)
- [Shopify's payment methods in Japan - Shopify JP Blog](https://www.shopify.com/jp/blog/payments-list-en)
- [How to Start a Shopify Store in Japan in 2025 - Praella](https://praella.com/blogs/shopify-news/how-to-start-a-shopify-store-in-japan-in-2025-a-comprehensive-guide)
- [Shopify Payments for Japan - Shopify Help Center](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries/japan)
- [Shopify 代金引換 설정 문제 - torublog](https://torublog.com/shopify-add-payment-cod/)
- [Payment methods to offer as an ecommerce business in Japan - Ship&Co](https://blog.shipandco.com/en/localize-your-ecommerce-brand-in-japan-payment-methods-for-ecommerce-business/)
- [KOMOJU makes konbini payments available on Shopify - Medium](https://medium.com/flagshipblog/komoju-makes-konbini-payments-available-on-shopify-7c15a201db3)

---

## 2025~2026 최신 수치 업데이트

> 출처: `latest-stats-2025-2026.md` (2026-03-06 조사)

### 일본 결제 수단 비중 (2024년 기준, 캐시리스 내 구성)

| 결제 수단 | 비중 | 금액 |
|-----------|------|------|
| 신용카드 | 82.9% | 116.9조 엔 |
| QR코드 결제 | 9.6% | 13.5조 엔 |
| 전자화폐 | 4.4% | 6.2조 엔 |
| 직불카드 | 3.1% | 4.4조 엔 |

### 캐시리스 결제 전환 현황

| 연도 | 캐시리스 비율 | 금액 |
|------|--------------|------|
| 2023년 | 39.3% | — |
| 2024년 | 42.8% | 141.0조 엔 |
| 정부 목표 (장기) | 80% | METI 로드맵 |

> 일본 정부의 2025년 40% 목표를 2024년에 이미 초과 달성.

### PayPay 동향 (2025)

| 지표 | 수치 |
|------|------|
| 등록 사용자 수 (2025년 7월) | 7,000만 명 이상 |
| QR코드 결제 시장 점유율 | 65.1% |
| 2위 Rakuten Pay | 36.0% |
| 3위 d-Payment | 28.6% |

**주요 동향:** LINE Pay 일본 서비스 2025년 4월 30일 종료 → 사용자 전량 PayPay로 이전. 편의점(세븐일레븐, 패밀리마트, 로손) 전점 PayPay 수락. 소비자들이 Suica(교통)·PayPay(소규모 가맹점)·신용카드(고가 구매) 등 다중 앱을 상황에 따라 혼용.

---

## [4-0] Stripe 한국·글로벌 결제 지원 현황

### 한국 국내결제 지원 여부

Stripe는 2024년 말부터 한국 국내 결제를 공식 지원하기 시작했다. NICEPay와의 파트너십을 통해 다음을 지원한다.

- **한국 카드사 카드 결제**: 20개 이상의 국내 카드 브랜드 지원 (현대카드, 삼성카드, KB국민카드 등 포함)
- **KakaoPay**: 공식 Stripe 결제수단으로 지원 (`docs.stripe.com/payments/kakao-pay`)
- **Naver Pay**: 공식 Stripe 결제수단으로 지원 (`docs.stripe.com/payments/naver-pay`)
- **PAYCO**: 공식 Stripe 결제수단으로 지원
- **원화(KRW) 결제**: 지원됨. 가격 표시는 KRW로 설정해야 함

**핵심 차별점**: 한국에 법인 없이도 위 결제수단을 수취할 수 있다. NICEPay가 중간 현지 파트너 역할을 하여 종단간 정산·리포팅을 제공한다.

**제약**: 국내 PG(이니시스, 토스페이먼츠)와 달리 한국 전자금융업 등록이 없어, 일부 기능(인증 기반 결제, 에스크로 등)은 지원하지 않을 수 있다.

### 크로스보더 정산 구조 (Stripe Connect)

Stripe Connect를 통해 한국 판매자 → 해외 구매자 크로스보더 정산이 가능하다.

- **구조**: 해외 구매자가 자국 카드·페이로 결제 → Stripe가 현지 통화로 수취 → 한국 판매자 계좌에 KRW 또는 USD로 정산
- **Stripe Connect 기능**: 플랫폼이 연결된 계정(Connected Account)에 결제를 라우팅하는 방식으로, 마켓플레이스·플랫폼 비즈니스에 적합
- **주의사항**: KRW → 외화 정산 시 환율 리스크 및 환전 수수료(약 1~2%) 발생. 외환거래법 규정 준수를 위해 Stripe가 현지 파트너 은행을 통해 자금을 라우팅하므로 정산 속도가 다소 느릴 수 있음
- **DCC(동적통화변환) 문제**: 카드 발급사에 따라 DCC가 자동 적용되어 소비자 실제 부담 금액이 달라질 수 있음. 이는 Stripe 자체 문제가 아닌 카드사 정책에 따른 것

일본에서 한국으로의 크로스보더 이커머스에 대해 Stripe는 별도 가이드를 제공하고 있다 (stripe.com/resources/more/cross-border-ecommerce-in-south-korea-from-japan).

### 한국 미지원 결제수단 및 대안

Stripe가 지원하지 않는 주요 한국 결제수단은 다음과 같다.

| 결제수단 | Stripe 지원 여부 | 대안 |
|---------|----------------|------|
| 무통장입금(가상계좌) | 미지원 | 이니시스, 토스페이먼츠 |
| 휴대폰 소액결제 | 미지원 | 이니시스, 토스페이먼츠 |
| 에스크로 결제 | 미지원 | 이니시스, 토스페이먼츠 |
| 계좌이체(실시간) | 미지원 | 이니시스, 토스페이먼츠 |
| 상품권·포인트 결제 | 미지원 | 별도 구축 필요 |

**국내 PG와의 비교**:
- **KG이니시스**: 국내 PG 1위. 한국 카드·가상계좌·실시간이체·에스크로 모두 지원하나, 해외 발급 카드는 지원 불가. 한국 법인·사업자등록 필수
- **토스페이먼츠**: 국내 결제 종합 지원. 결제 승인과 본인인증이 두 단계로 분리된 2-track 구조. 마찬가지로 해외 카드 미지원

### 국내 PG + Stripe 이원화 구조 실현 가능성

**실현 가능**: 국내 구매자는 이니시스/토스페이먼츠로, 해외 구매자는 Stripe로 처리하는 이원화 구조가 기술적으로 가능하며 실제로 사용되고 있다.

- **장점**: 국내 구매자에게 가상계좌·휴대폰 결제 등 완전한 결제 경험 제공 + 해외 구매자 대상 글로벌 결제 지원
- **단점**: 정산 채널이 2개로 분리되어 회계·정산 복잡도 증가. 각 PG와 별도 계약·수수료 발생. 개발 공수 2배
- **Shopify에서의 구현**: Shopify는 기본적으로 하나의 결제 게이트웨이를 주 게이트웨이로 사용하며, 국내 PG와 Stripe를 동시에 연동하려면 별도 앱 또는 커스텀 구현이 필요

### 일본 결제수단 Stripe 지원 여부

Stripe는 2025년 일본 현지 결제수단 지원을 대폭 확대했다.

| 결제수단 | Stripe 지원 | 비고 |
|---------|------------|------|
| 콘비니 결제 | **지원** | 일본 전국 34,000개 편의점 지원. Stripe Connect에도 추가됨 (2025-11-17) |
| PayPay | **지원** | 사용자 6,800만 명. 2025년 9월 Public Preview, 11월 Connect 지원 추가 |
| Furikomi(후리코미, 은행이체) | **지원** | Stripe가 2025년 일본 특화 기능으로 발표 |
| Paidy(후불결제) | 미지원 (직접) | 별도 Paidy 앱 연동 필요 |
| 口座振替(자동이체) | 미지원 | 일본 구독 서비스 표준 결제, 국내 처리 필요 |
| 着払い(착불) | 미지원 | 물류 시스템과 연동 문제 |

**중요**: Stripe는 일본 현지 결제수단 지원이 **KOMOJU보다 늦게 시작**되었지만, 2025년 들어 빠르게 따라잡고 있다. Connect를 통한 일본 판매자 지원도 가능해졌다. 단, 일본 법인 없이 일부 스마트폰 결제(PayPay 등)를 사용하려면 별도 심사(3~4주)가 필요할 수 있다.

---

## [4-1] Shopify 일본 결제 직접 지원 여부 검증

기존 조사 결과([4-1] 섹션 상단 참조)를 재확인한 결과, 다음이 확정된다.

**Shopify Payments 일본 네이티브 지원 현황 (2025~2026 기준)**:

| 결제수단 | Shopify Payments 네이티브 지원 |
|---------|-------------------------------|
| 콘비니 결제 | **미지원** |
| 후불결제(Paidy) | **미지원** |
| 은행 자동이체(口座振替) | **미지원** |
| PayPay | **미지원** |
| 신용카드(Visa/MC/JCB) | 지원 |
| Apple Pay / Google Pay | 지원 |
| PayPal | 지원 |

Shopify Payments 일본 공식 문서는 신용카드, Apple Pay, Google Pay, PayPal만을 네이티브 지원 목록에 포함한다. 콘비니 결제, 착불, 口座振替, 후불(あと払い) 등 일본 특유 결제수단은 네이티브로 지원하지 않으며, 반드시 KOMOJU 등 서드파티 앱 연동이 필요하다. 이 결론은 2026년 3월 기준에도 변경 없이 유효하다.

---

## [4-11] komoju 연동 불편함 상세

### 설치·설정 단계

KOMOJU의 Shopify 연동은 공식적으로 "코딩 없이 간단"하다고 홍보되지만, 실제 완전한 운용까지의 단계는 복잡하다.

**기본 설치 단계**:
1. Shopify 앱스토어에서 KOMOJU 앱 설치
2. KOMOJU 계정 생성 및 사업자 정보 제출 (심사 필요)
3. Shopify 관리자 → 설정 → 결제에서 KOMOJU를 서드파티 결제 게이트웨이로 추가
4. KOMOJU 대시보드에서 API 키 발급 후 Shopify에 입력
5. 활성화할 결제수단 개별 선택 (콘비니, PAY-EASY, 후불, 스마트폰 결제 등)

**스마트폰 결제(PayPay, LINE Pay 등) 추가 심사**:
- 스마트폰 결제는 각 결제수단 제공사(PayPay 등)별로 별도 심사를 받아야 함
- 심사 기간: 결제수단별 약 3~4주 소요
- **일본 법인 없는 해외 사업자는 스마트폰 결제 이용 불가** (KOMOJU 공식 정책)

### 이중 수수료·정산 분리 문제

KOMOJU를 Shopify에 연동하면 수수료 구조가 복잡해진다.

**수수료 체계**:
- KOMOJU 트랜잭션 수수료: 결제수단별 상이
  - 콘비니 결제: **2.75%**
  - 신용카드: **3.6%~3.85%**
  - PAY-EASY: 개별 요율
- Shopify 서드파티 수수료: Shopify Payments 미사용 시 추가 부과
  - Basic 플랜: 2.0%
  - Shopify 플랜: 1.0%
  - Advanced 플랜: 0.5%
- **실질 부담**: KOMOJU 수수료 + Shopify 서드파티 수수료가 중복 적용되어 총 부담이 4~6% 이상이 될 수 있음

**정산 분리 문제**:
- Shopify Payments를 통한 결제와 KOMOJU를 통한 결제의 정산 사이클이 다름
- Shopify Payments: 표준 정산 주기
- KOMOJU: 별도 정산 사이클 (마감일 기준 정산, 은행 이체 수수료 별도)
- 두 채널의 매출을 합산하려면 수동 대조가 필요하며, 회계·세무 처리가 복잡해짐
- 환불 시 KOMOJU 트랜잭션 수수료 환불 불가. 콘비니 결제 환불 시 건당 JPY 300 추가 수수료 발생

### 판매자 불만 사례

1. **장기 심사 대기**: PayPay 등 스마트폰 결제 심사에 3~4주 이상 소요. 런칭 일정에 영향을 미치며, 심사 결과가 보장되지 않음
2. **법인 요건 장벽**: 일본 법인이 없는 해외 판매자는 스마트폰 결제(가장 인기 있는 결제수단 중 하나)를 아예 사용할 수 없음
3. **이중 수수료 부담**: Shopify 서드파티 수수료 + KOMOJU 수수료 중복으로 마진 압박. Shopify Plus(서드파티 수수료 없음)로 업그레이드하지 않으면 해결 어려움
4. **콘비니 결제 미완료 위험**: 고객이 콘비니 결제 코드를 받고도 유효기간 내 납부하지 않는 경우 발생. 미납 시 재고는 홀딩됐다가 해제되는 운영 리스크 존재
5. **정산 대조 복잡**: KOMOJU와 Shopify Payments 정산 데이터를 별도로 다운로드해 수동으로 합산해야 함. 단일 대시보드에서 전체 매출 확인 불가

### 출처

- [How to accept payments in South Korea - Stripe](https://stripe.com/resources/more/payments-in-south-korea)
- [South Korean payment methods - Stripe Documentation](https://docs.stripe.com/payments/countries/korea)
- [Accept a payment using Kakao Pay - Stripe Documentation](https://docs.stripe.com/payments/kakao-pay/accept-a-payment)
- [Accept a payment using Naver Pay - Stripe Documentation](https://docs.stripe.com/payments/naver-pay/accept-a-payment)
- [Cross-border ecommerce from Japan to South Korea - Stripe](https://stripe.com/resources/more/cross-border-ecommerce-in-south-korea-from-japan)
- [Stripe KRW Local Payments and DCC Problem - PPMC Blog](https://blog.popekim.com/en/2025/11/02/stripe-krw-local-payment-dcc.html)
- [Does Stripe Work In Korea? - OneSafe Blog](https://www.onesafe.io/blog/does-stripe-work-in-korea)
- [Ask HN: Why isn't Stripe operating in South Korea? - Hacker News](https://news.ycombinator.com/item?id=39498484)
- [Korean payment gateways that can be linked with Shopify - Punch Korea](https://www.punchkorea.com/korean-payment-gateways-shopify/)
- [Stripe launches new features for Japan including PayPay - Stripe Newsroom](https://stripe.com/newsroom/news/japan-payments-moment-2025)
- [Konbini payments - Stripe Documentation](https://docs.stripe.com/payments/konbini)
- [Stripe launches Konbini and Furikomi - Stripe Newsroom](https://stripe.com/en-sk/newsroom/news/japan-local-payments)
- [Adds support for PayPay as a local payment method - Stripe Changelog](https://docs.stripe.com/changelog/clover/2025-09-30/add-paypay-public-preview)
- [Adds support for Konbini payments in Accounts v2 - Stripe Changelog](https://docs.stripe.com/changelog/clover/2025-11-17/accounts-v2-konbini-payments)
- [Use KOMOJU to add Japanese and Korean payments to Shopify - KOMOJU](https://en.komoju.com/integrations/shopify/)
- [About KOMOJU transaction fee - KOMOJU](https://en.komoju.com/help/492-about-komoju-transaction-fee/)
- [Integrating KOMOJU to Shopify - KOMOJU](https://en.komoju.com/help/520-integrating-komoju-to-shopify/)
- [KOMOJU Shopify Integration in Japan 2025 - KOMOJU Blog](https://en.komoju.com/blog/general-advice/shopify-integration-in-japan/)
- [About KOMOJU Usage Fees and Settlement Fees - KOMOJU Help Center](https://help.komoju.com/hc/en-us/articles/4747472702622-About-KOMOJU-Usage-Fees-and-Settlement-Fees)

---

## [4-5] Shopify·카페24 지원 국가 및 결제수단 (2025)

### Shopify Payments 지원 국가 (2025년 기준)

Shopify Payments는 2025년 3월 기준 약 **33개국**에서 이용 가능하다. 2025년 초 유럽 15개국을 추가로 지원하면서 크게 확장되었다.

**확정 지원 국가 목록 (2025년 기준):**

| 지역 | 국가 |
|-----|------|
| 북미 | 미국(US), 캐나다(CA), 멕시코(MX) |
| 유럽(기존) | 영국(UK), 아일랜드, 독일, 프랑스, 스페인, 이탈리아, 네덜란드, 벨기에, 오스트리아, 스위스, 체코, 루마니아, 덴마크, 핀란드, 스웨덴 |
| 유럽(2025년 신규) | 폴란드, 리투아니아, 노르웨이, 라트비아, 헝가리, 에스토니아, 몰타, 크로아티아, 그리스, 슬로베니아, 키프로스, 불가리아, 리히텐슈타인, 룩셈부르크, 지브롤터 |
| 오세아니아 | 호주(AU), 뉴질랜드(NZ) |
| 아시아 | 일본(JP), 싱가포르(SG), 홍콩(HK) |

**중요 — 한국(KR)은 Shopify Payments 미지원국이다.** 한국 법인은 Shopify Payments를 사용할 수 없으며, 반드시 KG이니시스, 토스페이먼츠, 포트원 등 서드파티 PG를 연동해야 한다.

### Shopify 일본에서 지원하는 결제수단

**Shopify Payments 네이티브 지원 (일본):**

| 결제수단 | 지원 여부 |
|---------|----------|
| Visa / Mastercard / JCB / AMEX | 지원 |
| Apple Pay | 지원 |
| Google Pay | 지원 |
| PayPal | 지원 |
| Shop Pay | 지원 |

**Shopify Payments 미지원 (일본 로컬 결제 — 서드파티 앱 필요):**

| 결제수단 | 대안 |
|---------|------|
| 콘비니 결제 (コンビニ払い) | KOMOJU |
| PayPay | KOMOJU |
| LINE Pay | KOMOJU |
| Rakuten Pay | KOMOJU |
| au PAY, Merpay, d Payment | KOMOJU |
| Paidy (후불결제) | Paidy 공식 앱 |
| 口座振替 (자동이체) | GMO PG, 별도 구축 |
| 着払い (착불 결제) | 물류 연동 필요 |

Shopify Payments 일본 지원 범위는 2026년 3월 기준 변경이 없다. 일본 시장 핵심 결제수단은 여전히 KOMOJU 등 서드파티 앱 의존이 불가피하다.

### 카페24 글로벌 지원 국가 및 결제수단

**카페24 글로벌 쇼핑몰 지원 범위:**

카페24는 9개 언어 멀티쇼핑몰을 제공하며, 약 **200여 개국** 소비자를 대상으로 한 배송 및 결제를 지원한다. 주요 지원 언어는 한국어, 영어, 일본어, 중국어(간체·번체), 베트남어, 스페인어, 태국어, 포르투갈어(브라질)이다.

**카페24 글로벌 PG 파트너 체계:**

카페24는 글로벌 PG사들과 제휴해 **150여 개 로컬 결제수단**을 한 번에 연동할 수 있는 구조를 제공한다.

> **⚠️ [8-9] 재검증 노트 (2026-03-10)**: 카페24 글로벌PG 신청 화면 기준으로 실제 제공 파트너를 재확인 필요. 기존에 "Paymentwall, PayPal, Alipay, Stripe 등"으로 기술되었으나 실제로는 다음이 확인됨:
> - **Stripe**: 카페24 공식 글로벌PG 신청 화면에서 직접 노출되지 않는 것으로 보임 (우회 연동 또는 과거 제공 후 중단 가능성 존재 — 추가 확인 필요)
> - **Alipay**: 엑심베이(Eximbay)를 통한 간접 제공 구조로 추정됨 (엑심베이가 카페24 공식 파트너 여부 확인 필요)
> - **Paymentwall, PayPal**: 현재도 활성 제공 중으로 확인됨
> - `research/cafe24-pro-analysis.md` 작성 시 이 내용을 반드시 최신 공식 출처로 재검증하여 반영할 것

주요 파트너 (재검증 전 잠정): Paymentwall, PayPal, Alipay(엑심베이 경유 추정) 등.

### 카페24 일본 진출 지원 — KG이니시스 제휴 (2026년 1월)

카페24는 2026년 1월 20일 KG이니시스와 제휴해 **'일본 결제 서비스'를 신규 출시**했다. 이 서비스는 한국 사업자가 일본 법인 없이 일본 현지 결제수단을 즉시 도입할 수 있도록 설계됐다.

**지원 결제수단 (카페24 × KG이니시스 일본 결제 서비스):**

| 카테고리 | 결제수단 |
|---------|---------|
| 신용카드 | Visa, Mastercard, JCB |
| 콘비니 결제 | 세븐일레븐, 로손, 패밀리마트 |
| 간편결제 | LINE Pay, au PAY, Merpay, 라쿠텐페이, 아마존페이 |

**핵심 특징:**
- 일본 법인 없이 국내 사업자등록증만으로 도입 가능
- 별도 개발 없이 카페24 스토어에서 클릭 몇 번으로 설정
- 거래 수수료 및 취소 수수료 전액 면제 (출시 프로모션)
- 일본 현지 발급 카드 직접 처리로 높은 승인율 확보

**시사점**: 카페24의 일본 결제 지원은 Shopify보다 한국 판매자 진입 장벽을 낮추는 방향으로 차별화되고 있다. 특히 일본 법인 불필요 + 수수료 면제 조건은 중소 판매자에게 매력적이다. 그러나 PayPay 미지원은 약점으로, Shopify+KOMOJU 대비 커버리지가 좁다.

### 플랫폼 비교 요약

| 항목 | Shopify Payments | 카페24 글로벌 |
|-----|----------------|------------|
| 지원 국가 수 | 약 33개국 | 200여 개국 (배송 기준), 결제는 PG 파트너 기반 |
| 한국 지원 | 미지원 | 지원 (한국 PG 연동) |
| 일본 지원 | 지원 (신용카드·글로벌 페이) | 지원 (KG이니시스 제휴로 콘비니·간편결제 포함) |
| 일본 콘비니 결제 | 서드파티(KOMOJU) 필요 | KG이니시스 제휴로 직접 지원 |
| 일본 PayPay | 서드파티(KOMOJU) 필요 | 미지원 (2026년 1월 기준) |
| 한국 판매자 편의성 | 낮음 (한국 PG 별도 계약) | 높음 (통합 관리 가능) |

### 출처

- [Shopify Help Center — Supported countries for Shopify Payments](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries)
- [Shopify Payments available in 15 additional European Countries - Shopify Changelog](https://changelog.shopify.com/posts/shopify-payments-available-in-14-additional-european-countries)
- [What Countries Does Shopify Support? (2025 Merchant Guide) - SellioApps](https://www.sellioapps.com/blogs/news/what-countries-does-shopify-support-2025-guide)
- [카페24 글로벌 솔루션 2025년 - 카페24](https://www.cafe24.com/story/use/globalsuccess.html)
- [카페24 글로벌 진출 페이지 - 카페24](https://www.cafe24.com/develop/global.html)
- [카페24, KG이니시스와 K-브랜드 일본 진출 지원 협력 - 머니투데이](https://www.mt.co.kr/stock/2026/01/20/2026012009343073350)
- [KG이니시스-카페24, '일본 결제 서비스' 론칭 - 이데일리](https://www.edaily.co.kr/News/Read?newsId=02417366645319688&mediaCodeNo=257)
- [KG이니시스-카페24 제휴 역직구 일본 진출 진입장벽 낮아진다 - KG이니시스 블로그](https://www.inicis.com/blog/archives/130609)
- [카페24, KG이니시스 손잡고 일본 결제 서비스 출시 - 서울경제](https://www.sedaily.com/NewsView/2K7DJQAIJ5)
