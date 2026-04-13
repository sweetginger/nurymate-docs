# Stripe PG 지원 현황 — 한국·일본 결제 조사

## 조사 목적

셀메이트CM가 국내결제(한국 PG)와 크로스보더 결제(Stripe)를 이원화하는 구조를 채택할 경우의 실현 가능성을 검토한다. 구체적으로는 Stripe의 한국 국내결제 지원 범위, 일본 결제수단 지원 현황, Stripe Connect 크로스보더 정산 구조, 그리고 이원화 구조 운영의 복잡도를 분석한다.

---

## 1. Stripe 한국 국내결제 지원 현황

### 1-1. 지원 시작 시점 및 배경

Stripe는 2024년 8월 싱가포르 Stripe Tour에서 NICEPay와의 파트너십을 공식 발표하며 한국 로컬 결제 지원을 시작했다. 이를 통해 **해외 법인을 보유한 사업자**가 한국 법인 없이도 한국 소비자의 원화 결제를 수취할 수 있게 되었다.

### 1-2. 지원되는 결제수단

| 결제수단 | 지원 여부 | 비고 |
|---------|----------|------|
| 한국 신용·체크카드 | **지원** | 20개 이상 국내 카드 브랜드 (현대, 삼성, KB국민 등) |
| 카카오페이 (KakaoPay) | **지원** | 공식 Stripe 결제수단 (`docs.stripe.com/payments/kakao-pay`) |
| 네이버페이 (Naver Pay) | **지원** | 공식 Stripe 결제수단 (`docs.stripe.com/payments/naver-pay`) |
| 삼성페이 (Samsung Pay) | **지원** | |
| PAYCO | **지원** | |
| 원화(KRW) 결제 | **지원** | 가격 표시를 KRW로 설정해야 함 |
| KRW 정기결제(구독) | **지원** | `docs.stripe.com/billing/subscriptions/kr-card` |

NICEPay가 중간 현지 파트너 역할을 하여 종단간 정산·리포팅을 제공한다. Stripe Checkout 및 Elements 모두에서 사용 가능하다.

### 1-3. 중요 제약사항

**한국 법인·사업자는 Stripe 계정을 직접 개설할 수 없다.** 한국은 현재 Stripe의 공식 Merchant Country(가맹 국가)가 아니며, 한국 사업자등록증 기반으로 Stripe 계정을 만드는 것은 2026년 3월 기준 불가능하다. 이 기능은 Stripe 계정을 이미 보유한 **해외 법인(미국, 싱가포르, 일본 등)** 이 한국 고객을 수취하는 구조에서만 동작한다.

추가로 DCC(동적 통화 변환) 문제가 보고되고 있다. 카드 발급사에 따라 DCC가 자동 적용되어 소비자 실제 부담 금액이 달라질 수 있으며, 이는 Stripe 자체 문제가 아닌 카드사 정책에 따른 것이나 고객 불만으로 이어질 수 있다.

---

## 2. Stripe Connect 크로스보더 정산 구조

### 2-1. 기본 구조

Stripe Connect는 플랫폼이 연결된 계정(Connected Account)에 결제를 라우팅하는 방식으로, 마켓플레이스·플랫폼 비즈니스에 적합하다.

```
해외 구매자 (일본, 미국 등)
    ↓ 자국 카드·페이로 결제
Stripe (현지 통화로 수취)
    ↓ 환율 적용 + 환전 수수료(약 1~2%)
한국 판매자 계좌 (KRW 또는 USD 정산)
```

### 2-2. 한국 판매자 정산 지원 현황

Stripe의 자체 Cross-Border Payouts(Connect를 통한 크로스보더 정산)는 현재 **미국, 영국, EEA, 캐나다, 스위스** 소재 플랫폼에서만 자동 지원된다. 한국 소재 법인은 이 셀프서브 크로스보더 정산 프로그램에 포함되지 않는다.

그러나 2025년 12월 기준 Stripe의 Global Payouts 프로그램은 50개국 이상으로 확대되었으며, 한국 포함 여부는 별도 Enterprise 계약을 통해 확인이 필요하다. 일본→한국 크로스보더 이커머스에 대한 Stripe 전용 가이드(`stripe.com/resources/more/cross-border-ecommerce-in-south-korea-from-japan`)가 존재하는 점은 긍정적 신호다.

### 2-3. 정산 관련 비용

- 환율 전환 수수료: 약 1~2% (Stripe 정책에 따라 상이)
- 외환거래법 준수를 위해 현지 파트너 은행을 통해 자금을 라우팅하므로 정산 속도가 일반 도메스틱 정산 대비 느릴 수 있음
- KRW→외화 또는 외화→KRW 환전 시 환율 리스크 발생

---

## 3. 한국 PG사 대안 목록 (이원화 구조)

Stripe가 지원하지 않는 주요 한국 결제수단과 대안 PG사는 다음과 같다.

| 결제수단 | Stripe 지원 | 대안 PG사 | 비고 |
|---------|------------|---------|------|
| 무통장입금(가상계좌) | 미지원 | KG이니시스, 토스페이먼츠, NHN KCP | 한국 소비자 선호도 높음 |
| 휴대폰 소액결제 | 미지원 | KG이니시스, 토스페이먼츠 | 청소년·소액 결제에 필수 |
| 계좌이체(실시간) | 미지원 | KG이니시스, 토스페이먼츠 | |
| 에스크로 결제 | 미지원 | KG이니시스, 토스페이먼츠 | 전자상거래법상 특정 품목 의무 |
| 상품권·포인트 결제 | 미지원 | 별도 구축 필요 | |
| 해외 카드(Visa/MC) | **지원** | — | Stripe가 더 유리 |
| 카카오페이, 네이버페이 | **지원** | KG이니시스, 토스페이먼츠도 지원 | 이중 지원 |

**주요 국내 PG사 특성 비교:**

| PG사 | 강점 | 약점 |
|------|-----|------|
| KG이니시스 | 국내 PG 시장 1위, 모든 국내 결제수단 지원, 일본 결제 서비스 신규 출시 | 해외 발급 카드 미지원, 한국 법인 필수 |
| 토스페이먼츠 | UX 우수, 개발자 친화적 API, 구독/정기결제 지원 | 해외 카드 미지원, 한국 법인 필수 |
| NHN KCP | 대용량 트랜잭션 처리 강점 | API 레거시, 개발자 UX 낮음 |
| 포트원(PortOne) | 다중 PG 통합 미들웨어 (이니시스+Stripe 동시 연동 가능) | 추가 수수료 발생 |

---

## 4. 이원화 구조 실현 가능성 평가

### 4-1. 기술적 실현 가능성: 가능

국내 구매자는 국내 PG(KG이니시스/토스페이먼츠)로, 해외 구매자는 Stripe로 처리하는 이원화 구조는 기술적으로 가능하며 실제로 한국 이커머스 플랫폼들에서 사용되는 방식이다.

**구현 패턴:**
- IP/언어 감지 → 국내 PG 또는 Stripe 자동 라우팅
- 포트원(PortOne) 같은 PG 통합 미들웨어를 사용하면 단일 API로 양쪽 연동 가능
- 셀메이트CM가 직접 PG 연동을 구현할 경우 각 PG별 별도 SDK/API 연동 필요

### 4-2. 운영적 복잡도: 높음

| 항목 | 단일 PG | 이원화 구조 |
|------|--------|----------|
| 계약 수 | 1개 | 2개 이상 |
| 정산 채널 | 1개 | 2개 (정산 주기·통화 상이) |
| 회계 처리 | 단순 | 복잡 (외화 환산, 채널별 대조) |
| 개발 공수 | 기준 | 약 2배 |
| 수수료 비용 | 단일 | 채널별 상이, 환전 수수료 추가 |
| 환불 처리 | 단일 흐름 | PG별 상이한 환불 정책 |

### 4-3. 셀메이트CM 적용 시 고려사항

- **필수 조건**: 셀메이트CM 플랫폼이 해외 법인(일본 또는 싱가포르 등) 명의로 Stripe 계정을 개설해야 한다. 한국 법인만으로는 Stripe 계정 개설 불가.
- **권장 접근**: 초기에는 포트원(PortOne) 같은 PG 통합 미들웨어를 활용해 KG이니시스+Stripe 이원화를 단일 통합으로 구현하는 것이 개발 공수를 줄이는 방법이다.
- **판매자 입장**: 플랫폼이 정산을 통합 관리해준다면 판매자는 단일 정산 리포트를 받을 수 있으나, 셀메이트CM 백오피스에서 이중 정산을 통합·집계하는 로직 구현이 필요하다.

---

## 5. 일본 결제수단 Stripe 지원 여부

Stripe는 2025년 일본 현지 결제수단 지원을 대폭 확대하며 일본 시장에 적극 투자했다.

### 5-1. 지원되는 일본 결제수단

| 결제수단 | Stripe 지원 여부 | 출시 시점 | 비고 |
|---------|----------------|---------|------|
| 콘비니 결제 (Konbini) | **지원** | 기존 + 2025년 Connect 추가 (2025-11-17) | FamilyMart, Lawson, Ministop, Seicomart 4대 체인 |
| PayPay | **지원** | 2025년 9월 Public Preview → 11월 Connect 지원 | 일본 사용자 6,800만 명 이상 |
| Furikomi (후리코미, 은행 이체) | **지원** | 2025년 | 일본 특화 기능으로 발표 |
| 신용카드 (Visa/MC/JCB/AMEX) | **지원** | 기존 | 3DS 의무화(2025년 3월) 대응 완료 |
| Apple Pay / Google Pay | **지원** | 기존 | |
| WeChat Pay | **지원** | Stripe Terminal(인스토어) | |

### 5-2. 미지원 일본 결제수단

| 결제수단 | Stripe 지원 여부 | 대안 |
|---------|----------------|------|
| LINE Pay | **미지원** (직접 통합 없음) | KOMOJU, GMO PG 연동 |
| Paidy (후불결제, BNPL) | **미지원** | Paidy 자체 플러그인 별도 연동 |
| 口座振替 (자동이체, 구독) | **미지원** | 일본 로컬 PG 필요 |
| 着払い (착불 결제) | **미지원** | 물류 연동 필요, 디지털 결제 불가 구조 |
| Rakuten Pay | **미지원** | KOMOJU 경유 |
| au PAY, d payment | **미지원** | KOMOJU 경유 |

### 5-3. Stripe 일본 법인 및 계정 개설 조건

Stripe는 일본에 현지 법인을 두고 있다(**Stripe Japan K.K.**). 일본 Stripe 계정 개설을 위한 요건은 다음과 같다.

- **일본 법인 등록**: 법인 등록증(登記簿謄本) 및 세금 식별 번호 필요
- **일본 내 실물 주소**: 사무소 주소가 있어야 함
- **대표자 본인인증**: KYC 절차 (여권 또는 마이넘버 카드)
- **은행 계좌**: 일본 현지 은행 계좌 (정산 수취용)
- **추가 심사 항목**: PayPay 등 일부 스마트폰 결제는 Stripe 심사 외에 해당 결제수단 제공사의 별도 심사(약 3~4주) 필요

**중요**: 한국 법인이 일본 사업자 등록 없이 Stripe Japan 계정을 개설하는 것은 불가하다. 일본 진출을 위해서는 일본 현지 법인 설립 또는 파트너사를 통한 간접 구조가 필요하다.

---

## 6. 결론 및 셀메이트CM 적용 방향

### 6-1. Stripe 활용 가능 영역

| 시나리오 | Stripe 활용 가능 여부 | 조건 |
|---------|------------------|------|
| 한국 소비자 → 해외 플랫폼 결제 수취 | 가능 | 해외 법인 보유 시 |
| 일본 소비자 결제 수취 (콘비니·PayPay 포함) | 가능 | 일본 법인 or 파트너 구조 |
| 해외 소비자 → Stripe 크로스보더 | 가능 | 미국·싱가포르 등 법인 기준 |
| 한국 법인이 직접 Stripe 계정 개설 | **불가** | 2026년 3월 기준 |

### 6-2. 셀메이트CM 권장 아키텍처

```
[국내 결제 레이어]          [크로스보더 레이어]
KG이니시스 or              Stripe (해외 법인 기준)
토스페이먼츠                ├── 일본: Konbini, PayPay
├── 한국 카드               ├── 글로벌: Visa/MC/AMEX
├── 가상계좌                └── 한국 소비자: KRW Local Cards
├── 휴대폰 결제                 (NICEPay 경유)
└── 에스크로

          ↓ 통합
    포트원(PortOne) 미들웨어
          ↓
    셀메이트CM 정산 대시보드
```

### 6-3. 핵심 결론

1. **Stripe 단독으로 한국 국내 결제를 완전 대체하는 것은 불가능하다.** 가상계좌, 휴대폰 소액결제, 에스크로 등 핵심 국내 결제수단을 지원하지 않는다.
2. **이원화 구조(국내 PG + Stripe)는 기술적으로 실현 가능**하나, 운영 복잡도와 개발 공수가 약 2배 증가한다. 포트원 같은 통합 미들웨어 도입을 강력 권장한다.
3. **일본 시장에서 Stripe는 2025년 이후 빠르게 성장**하며 콘비니, PayPay를 지원하기 시작했으나, LINE Pay·Paidy·口座振替 등 일부 수단은 여전히 미지원이다. KOMOJU 병행이 필요한 상황은 단기적으로 지속될 전망이다.
4. **법인 구조가 핵심 제약**: 셀메이트CM가 Stripe를 활용하려면 해외 법인(일본 또는 싱가포르 등) 보유가 전제 조건이다.

---

## 참고 출처

- [South Korean payment methods - Stripe Documentation](https://docs.stripe.com/payments/countries/korea)
- [Accept a payment using local cards in South Korea - Stripe](https://docs.stripe.com/payments/kr-card/accept-a-payment)
- [How to accept payments in South Korea - Stripe](https://stripe.com/resources/more/payments-in-south-korea)
- [Accept a payment using Kakao Pay - Stripe Documentation](https://docs.stripe.com/payments/kakao-pay/accept-a-payment)
- [Accept a payment using Naver Pay - Stripe Documentation](https://docs.stripe.com/payments/naver-pay/accept-a-payment)
- [Cross-border ecommerce from Japan to South Korea - Stripe](https://stripe.com/resources/more/cross-border-ecommerce-in-south-korea-from-japan)
- [Cross-border payouts - Stripe Documentation](https://docs.stripe.com/connect/cross-border-payouts)
- [Global Payouts adds support for 13 new countries - Stripe Changelog](https://docs.stripe.com/changelog/clover/2025-12-15/cross-border-payouts-new-countries)
- [Stripe KRW Local Payments and DCC Problem - PPMC Blog](https://blog.popekim.com/en/2025/11/02/stripe-krw-local-payment-dcc.html)
- [Stripe boosts cross-border commerce in Asia - Stripe Newsroom](https://stripe.com/newsroom/news/tour-singapore-2024)
- [Stripe launches new features for businesses in Japan, including PayPay - Stripe Newsroom](https://stripe.com/newsroom/news/japan-payments-moment-2025)
- [Konbini payments - Stripe Documentation](https://docs.stripe.com/payments/konbini/accept-a-payment)
- [Adds support for Konbini payments in Accounts v2 - Stripe Changelog](https://docs.stripe.com/changelog/clover/2025-11-17/accounts-v2-konbini-payments)
- [Stripe launches Konbini and Furikomi - Stripe Newsroom](https://stripe.com/newsroom/news/japan-local-payments)
- [Stripe expands services in Japan, Terminal launch - Stripe Newsroom](https://stripe.com/newsroom/news/tour-tokyo-2025)
- [How to open a Stripe account in Japan - doola](https://www.doola.com/stripe-guide/how-to-open-a-stripe-account-in-japan/)
- [Adds support for new South Korean payment methods - Stripe Changelog](https://docs.stripe.com/changelog/acacia/2024-10-28/south-korean-payment-methods)
- [Stripe 10월 부터 한국결제 가능 설명 - Threads](https://www.threads.com/@dalgom.bami/post/DPRAWfBEnZT/)
- [국내 법인으로 스트라이프 결제가 안 되는 이유 - Premia TNC](https://premiatnc.com/kr/인사이트/블로그/싱가포르/스트라이프-싱가포르-법인-활용-blogging/)
- [해외결제 페이팔 아니면 스트라이프만 정답일까 - PortOne Blog](https://blog.portone.io/opi_globalpayment-krpg/)
