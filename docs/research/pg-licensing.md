# Shopify Payments·카페24 Payments PG업 영위 여부 조사 [4-20]

> 조사일: 2026-03-10 | 목적: 셀메이트CM 결제 인프라 설계 및 법적 구조 파악

---

## 1. Shopify Payments 운영 구조

### 1-1. 자체 PG인가, Stripe 래핑인가

**결론: Stripe를 핵심 인프라로 래핑한 구조이나, 국가별로 현지 PG 파트너와 병행한다.**

| 항목 | 내용 |
|------|------|
| 카드 처리 핵심 인프라 | Stripe (대부분의 지원 국가) |
| 브랜딩 | Shopify Payments (Shopify 자체 브랜드로 통합 제공) |
| 카드 저장·토큰화 | Stripe의 인프라 활용 |
| 결제 흐름 통합 | Shopify 체크아웃 내에 완전 임베드 |
| 사기 탐지 | Shopify의 Fraud Protect + Stripe의 Radar |

Shopify Payments는 독립된 PG 면허를 보유한 자체 결제사업자가 아니라, **Stripe의 결제 인프라 위에 Shopify가 상인 경험(UX, 대시보드, 리포팅)을 래핑한 화이트레이블 구조**다. 단, 일부 국가에서는 현지 규제 대응을 위해 Stripe 대신 혹은 Stripe와 함께 현지 PG 파트너를 사용한다.

### 1-2. Shopify Payments가 PG 면허를 보유하지 않는 이유

- Shopify는 이커머스 플랫폼 사업자이며, 각국에서 PG(전자지급결제대행업) 면허를 자체적으로 취득하는 대신 **이미 면허를 보유한 Stripe 또는 현지 PG와 파트너십**을 통해 서비스를 제공한다.
- 이는 글로벌 확장 시 규제 리스크와 비용을 최소화하는 전형적인 PSP(Payment Service Provider) 모델이다.
- Shopify 자체는 이커머스 플랫폼으로서 **전자상거래 결제 중개 역할**을 하며, 실제 자금 이동과 PG 기능은 파트너사가 담당한다.

---

## 2. 각국 Shopify Payments의 현지 PG 파트너

### 2-1. 미국

| 항목 | 내용 |
|------|------|
| 핵심 PG 파트너 | Stripe |
| 카드 브랜드 지원 | Visa, Mastercard, Amex, Discover |
| 추가 결제수단 | Shop Pay, Apple Pay, Google Pay, PayPal |
| 규제 기관 | FinCEN, 각 주 MSB(Money Services Business) |

### 2-2. 일본

| 항목 | 내용 |
|------|------|
| 핵심 PG 파트너 | **SB Payment Service (소프트뱅크 자회사, SBPS)** |
| 역할 | Shopify Payments의 일본 백엔드 처리 담당 |
| 지원 결제수단 | 신용·체크카드, 편의점(콘비니) 결제, Pay-easy, 모바일 결제 |
| 추가 로컬 결제 (외부 앱) | PayPay, Rakuten Pay, LINE Pay (Shopify 앱으로 별도 연동) |
| 규제 기관 | 금융청(FSA), 자금결제법 |

> SB Payment Service는 소프트뱅크 그룹 산하의 일본 전문 PG사로, Shopify가 일본에서 현지 규정(자금결제법)을 준수하기 위해 직접 계약한 파트너다. "Shopify Payments의 백엔드는 SBPS를 사용한다"는 점은 SBPS 공식 파트너 페이지에서 확인 가능하다.

### 2-3. 한국

| 항목 | 내용 |
|------|------|
| Shopify Payments 지원 여부 | **미지원** — 한국은 Shopify Payments 지원 국가가 아님 |
| 한국 고객 결제 처리 방법 | 외부 결제 앱(KG이니시스, Eximbay, KOMOJU 등) 연동 |
| KG이니시스 | 한국 법인 발급 카드만 처리 가능, 해외 카드 불가 |
| Eximbay | 한국 법인이 해외 구매자 결제 수취 가능한 크로스보더 PG |
| KOMOJU | 한국·일본 결제수단(NaverPay, KakaoPay, Konbini 등)을 Shopify에 통합 |

### 2-4. 유럽 주요 국가

| 국가 | PG 파트너 |
|------|-----------|
| 영국 | Stripe UK (영국 FCA 인가) |
| 독일·프랑스·EU | Stripe (각국 현지 규제 준수, EMI 라이선스 보유) |
| 신규 추가 15개국 (2025년) | 폴란드, 리투아니아, 노르웨이, 라트비아, 헝가리, 에스토니아, 몰타, 크로아티아, 그리스, 슬로베니아, 키프로스, 불가리아, 리히텐슈타인, 룩셈부르크, 지브롤터 |

---

## 3. 카페24 Payments의 PG 면허 보유 여부 및 운영 구조

### 3-1. 카페24 Payments 자체 PG 여부

**결론: 카페24 Payments는 자체 PG 면허를 보유하지 않으며, 토스페이먼츠(Toss Payments)를 핵심 PG 파트너로 사용하는 래핑 서비스다.**

| 항목 | 내용 |
|------|------|
| 서비스 명칭 | 카페24 페이먼츠 (카페24 Payments) |
| 실제 처리 PG | **토스페이먼츠 (Toss Payments, 구 LG U+ PG)** |
| 자체 전자지급결제대행업 등록 | 해당 없음 (카페24는 이커머스 솔루션 사업자) |
| 카페24의 역할 | 쇼핑몰 솔루션 제공사로서, 가맹점과 PG사 간 연결 및 결제 UI 통합 |

카페24는 전자금융거래법상 전자지급결제대행업자(PG사)로 직접 등록된 회사가 아니며, **카페24 Payments라는 명칭은 카페24가 토스페이먼츠와 체결한 제휴 서비스의 브랜드명**이다. 실제 결제 처리, 자금 정산, 부정거래 탐지는 토스페이먼츠가 담당한다.

### 3-2. 카페24가 제공하는 PG 연동 방식

카페24 쇼핑몰 운영자는 아래 두 가지 방식으로 결제를 처리할 수 있다:

**방식 A: 카페24 Payments (토스페이먼츠 제휴)**
- 카페24 가입 시 별도 PG 계약 없이 즉시 사용 가능
- 토스페이먼츠 인프라 기반, 카드·계좌이체·간편결제 등 포함
- 카페24가 일괄 계약 체결 → 개별 쇼핑몰은 별도 PG 가입 심사 없음 (간소화)

**방식 B: 외부 PG사 직접 연동**
카페24는 다수의 외부 PG사와 연동 모듈을 제공하며, 쇼핑몰 운영자가 직접 PG사와 계약 후 연동:

| PG사 | 특징 |
|------|------|
| KG이니시스 | 국내 최대 PG사, 카드·계좌이체·가상계좌 |
| KCP (NHN KCP) | 카드, 간편결제 |
| Nice Payments | 카드, 계좌이체 |
| KSNET | 카드 중심 |
| 헥토파이낸셜 | 간편결제, 소액결제 |
| KG모빌리언스 | 휴대폰 소액결제 |
| 다날 | 휴대폰 소액결제 |
| Paymentwall | 글로벌 해외 결제 |

---

## 4. 카페24와 국내 PG사 연동 방식

### 4-1. 기술적 연동 구조

```
소비자 브라우저
      ↓ (결제 요청)
카페24 쇼핑몰 체크아웃 UI
      ↓ (결제 팝업 or Redirect)
PG사 결제창 (이니시스/KCP/토스페이먼츠 등)
      ↓ (카드사/은행 인증)
카드사 / 은행
      ↓ (승인 결과)
PG사 → 카페24 → 쇼핑몰 (주문 완료 처리)
      ↓ (정산 D+2~7)
쇼핑몰 운영자 계좌
```

### 4-2. 계약 구조

| 구분 | 카페24 Payments | 외부 PG 직접 계약 |
|------|-----------------|------------------|
| 계약 주체 | 카페24 ↔ 토스페이먼츠 (일괄 계약) | 쇼핑몰 운영자 ↔ PG사 (개별 계약) |
| 수수료 | 카페24 협정가 (약 2~3%) | 개별 협상 (대형 몰은 낮은 수수료 가능) |
| 가입비 | 카페24를 통하면 면제 또는 할인 | PG사별 상이 |
| 심사 | 카페24를 통하면 간소화 | PG사 자체 심사 |

---

## 5. PSP vs PG 구분 기준

Shopify Payments와 카페24 Payments 모두 **엄밀한 의미에서 PG(Payment Gateway)가 아닌 PSP(Payment Service Provider) 또는 결제 중개 플랫폼**에 가깝다.

### 5-1. 개념 구분

| 구분 | PG (Payment Gateway) | PSP (Payment Service Provider) |
|------|---------------------|-------------------------------|
| 정의 | 결제 데이터를 카드사·은행 간에 안전하게 전달하는 기술적 게이트웨이 | 결제 전 과정(게이트웨이 + 심사·정산·리스크관리)을 통합 제공하는 사업자 |
| 자금 보유 | 일반적으로 미보유 | 일시적 보유 후 정산 |
| 예시 | 기술적 연결고리 역할의 초기 PG사 | Stripe, PayPal, 토스페이먼츠, Adyen |
| 규제 | 게이트웨이 기능 중심 | 전자지급결제대행업 등록 필요 |

### 5-2. 한국 법률상 정의

한국의 **전자금융거래법(EFTA)**에서 규정하는 **전자지급결제대행업(PG업)**은 국제 기준의 PSP를 포괄하는 광의의 개념이다:
- "재화 또는 용역을 구입하는 자가 대가를 지불하는 것을 대행하거나 그 대가의 정산을 매개하는 것"
- 자본금 요건: 분기 결제대행액에 따라 3억~20억 원
- 인적 요건: 2년 이상 경력 전산 전문인력 5인 이상
- 물적 요건: 백업장치, 정보보호시스템 구축

> **Shopify와 카페24는 위 PG업 등록 대상이 아니다.** 이들은 이커머스 플랫폼으로서 등록된 PG사(Stripe, 토스페이먼츠 등)와 계약해 결제 서비스를 제공하는 구조다.

---

## 6. 셀메이트CM가 PG 면허 없이 결제를 중개하는 구조의 합법성

### 6-1. 핵심 판단 기준

셀메이트CM가 PG 면허 없이 결제를 중개하는 것이 합법적인지는 **아래 세 가지 조건에 달려 있다:**

| 조건 | 판단 기준 |
|------|-----------|
| 자금 보유 여부 | 셀메이트CM가 결제 자금을 자사 계좌에 일시 보유하는가 |
| 정산 매개 여부 | 셀러에게 직접 정산을 수행하는가 |
| 반복·계속성 여부 | 다수 판매자 대상으로 반복·지속적으로 결제 대행하는가 |

이 세 가지 모두 해당될 경우, 한국 법상 **전자지급결제대행업 등록 의무**가 발생할 수 있다.

### 6-2. 합법적 구조를 위한 참고 모델

| 모델 | 설명 | 법적 지위 |
|------|------|-----------|
| **Shopify 모델** | 이커머스 플랫폼이 Stripe 등 등록 PG와 계약 → 자금 흐름은 PG가 처리 | 플랫폼은 PG 등록 불필요 |
| **카페24 모델** | 솔루션 사업자가 토스페이먼츠와 일괄 계약 → 개별 쇼핑몰은 PG 계약 없이 결제 가능 | 동일 |
| **Stripe Connect 모델** | 플랫폼이 Stripe와 계약 → Stripe가 셀러(Connected Account)에게 직접 정산 | 플랫폼은 Application Fee만 수취 |
| **Paymentwall 모델** | 글로벌 PG가 자금 흐름 담당, 플랫폼은 수수료 차익 수취 | PG 면허 불필요 |

### 6-3. 셀메이트CM에 대한 구조적 권고

- **자금이 셀메이트CM 계좌를 경유하지 않는 구조**를 설계해야 PG업 등록 의무를 회피할 수 있다.
- **Stripe Connect의 Application Fee 방식:** Stripe가 셀러에게 직접 정산하고, 셀메이트CM는 Application Fee(수수료)만 수취 → 자금 경유 없음 → PG업 등록 불필요.
- **한국 운영 시 주의:** 한국에서 사업을 영위하며 다수 한국 셀러의 결제를 반복적으로 대행한다면 금융위원회의 PG업 등록 의무 대상이 될 수 있으므로 전문 법률 자문 필수.

---

## 출처

- [Shopify Payments 지원 국가 공식 헬프 센터](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries)
- [Shopify Payments Japan 공식 헬프 센터](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries/japan)
- [SB Payment Service × Shopify 파트너 페이지](https://www.sbpayment.jp/en/service/partner/shopify/lp02/)
- [KOMOJU × Shopify 일본·한국 결제 연동](https://en.komoju.com/integrations/shopify/)
- [Shopify Integration in Japan 2025 - KOMOJU](https://en.komoju.com/blog/general-advice/shopify-integration-in-japan/)
- [한국 Shopify 결제 게이트웨이 - Punch Korea](https://www.punchkorea.com/korean-payment-gateways-shopify/)
- [카페24 페이먼츠(PG) 헬프 센터](https://support.cafe24.com/hc/ko/articles/7750852598169)
- [카페24 PG 신청·심사 FAQ](https://support.cafe24.com/hc/ko/articles/17299990270105)
- [전자지급결제대행업(PG업) 등록 요건 - 플래텀](https://platum.kr/archives/209263)
- [전금법 개정 PG 규제체계 - Lexology](https://www.lexology.com/library/detail.aspx?g=f588f901-de07-4e44-9585-55631b10fcc8)
- [FSC 한국 PG 규제 개선안 발표](https://www.fsc.go.kr/no010101/83047)
- [한국 Fintech 규제 2024-2025 - ICLG](https://iclg.com/practice-areas/fintech-laws-and-regulations/korea)
- [Shopify Payments vs Stripe 비교 - Enstacked](https://enstacked.com/difference-between-shopify-payments-and-stripe/)
- [Payment Service Provider 정의 - Wikipedia](https://en.wikipedia.org/wiki/Payment_service_provider)
- [FSC 전금법 개정 PG 정산 자금 보호 - 화우](https://www.hwawoo.com/kor/insights/newsletter/13152)
