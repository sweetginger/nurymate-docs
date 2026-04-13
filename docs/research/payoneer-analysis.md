# Payoneer 글로벌 결제 플랫폼 조사

**작성일**: 2026-03-11
**관련 태스크**: [13-12]
**상태**: Draft

---

## 1. 서비스 개요

Payoneer는 2005년 설립된 글로벌 B2B 결제 플랫폼으로, 나스닥(PAYO) 상장사다. 전 세계 200개 이상 국가에서 프리랜서, 이커머스 셀러, 마켓플레이스 운영사에게 크로스보더 결제 수취·송금·가상 은행 계좌 서비스를 제공한다.

**주요 서비스:**
- 크로스보더 결제 수취 (글로벌 마켓플레이스 정산 수취)
- 마켓플레이스 결제 (Payoneer for Platforms — 서브머천트 구조)
- 글로벌 송금 (B2B 송금, 공급업체 결제)
- 가상 은행 계좌 (미국·EU·영국·일본·홍콩 등 현지 계좌 발급)

---

## 2. 지원 국가 및 통화

| 항목 | 현황 |
|------|------|
| 지원 국가 | 200개 이상 |
| 지원 통화 | 70개 이상 |
| 가상 계좌 발급 국가 | 미국(USD), EU(EUR), 영국(GBP), 일본(JPY), 홍콩(HKD), 캐나다(CAD), 호주(AUD) |
| 한국 지원 | 한국 사업자 KRW 수취 및 출금 가능 |
| 일본 지원 | 일본 사업자 JPY 수취 및 현지 은행 출금 가능 |

---

## 3. 수수료 구조

| 항목 | 수수료 |
|------|--------|
| 결제 수취 | 수취 자체는 수수료 없음 (일부 조건부) |
| 출금 수수료 | 현지 은행 출금 $1.50~$3 / 건 (국가별 상이) |
| 환전 수수료 | 2~3.5% (Mid-market rate 기준) |
| Payoneer → Payoneer 송금 | 무료 (동일 통화) |
| Payoneer Balance → 은행 | 건당 수수료 부과 |
| 마켓플레이스 수취 | 무료 (Payoneer 파트너 마켓플레이스에서 수취 시) |

---

## 4. Payoneer for Platforms (마켓플레이스/플랫폼 모델)

### 4.1 서비스 개요

Payoneer for Platforms는 마켓플레이스·플랫폼 운영사가 글로벌 셀러에게 결제를 분배(Payout)하는 솔루션이다.

**구조:**
```
플랫폼 (셀메이트CM 등)
    │ (Payoneer for Platforms API)
    ▼
Payoneer
    │ 자동 분배
    ▼
셀러 A (한국) — Payoneer 계좌 → KRW 출금
셀러 B (일본) — Payoneer 계좌 → JPY 출금
셀러 C (미국) — Payoneer 계좌 → USD 출금
```

**특징:**
- 플랫폼이 결제를 수취한 뒤 Payoneer API를 통해 셀러에게 자동 분배
- 200개국 이상 셀러에게 현지 통화로 지급 가능
- 셀러가 Payoneer 계좌만 있으면 별도 은행 계좌 연동 불필요
- 대량 일괄 지급(Mass Payout) 지원

### 4.2 마켓플레이스 파트너 프로그램

Payoneer 공인 마켓플레이스 파트너 등록 시:
- 셀러 수취 수수료 무료 (Payoneer 파트너 수취)
- 플랫폼에 리퍼럴 수익 제공
- 전담 계정 매니저 배정

---

## 5. 한국·일본 지원 현황

### 5.1 한국

| 항목 | 현황 |
|------|------|
| 계정 개설 | 한국 사업자등록증 기반 개설 가능 |
| KRW 수취 | 가상 한국 계좌 없음 → 외화(USD 등) 수취 후 원화 출금 |
| 출금 방법 | 국내 은행 계좌 연결 → 원화 출금 |
| 수취 가능 마켓플레이스 | Amazon, Etsy, Upwork, Fiverr 등 300개+ |

### 5.2 일본

| 항목 | 현황 |
|------|------|
| 계정 개설 | 일본 사업자 개설 가능 |
| JPY 가상 계좌 | 제공 (일본 현지 계좌번호 발급) |
| 출금 방법 | 일본 내 은행 계좌 연결 → JPY 출금 |
| 일본 내 결제 수취 | 주로 글로벌 마켓플레이스 정산 수취 용도 |

---

## 6. 셀메이트CM 활용 가능성 분석

### 6.1 장점

| 장점 | 설명 |
|------|------|
| 글로벌 셀러 정산 특화 | 200개국 셀러에게 단일 플랫폼으로 정산 가능 |
| 한국·일본 사업자 지원 | 양국 셀러 모두 Payoneer 계좌 수취 가능 |
| 마켓플레이스 파트너 프로그램 | 공인 파트너 등록 시 리퍼럴 수익 + 셀러 무료 수취 |
| 대량 일괄 지급 API | 다수 셀러에 대한 자동화 정산 처리 가능 |
| 글로벌 확장성 | 동남아·유럽 셀러까지 단일 정산 도구로 확장 가능 |

### 6.2 단점 및 한계

| 한계 | 설명 |
|------|------|
| 소비자 결제 수단 미지원 | 신용카드, 콘비니 결제 등 소비자 결제 처리 불가 (주로 B2B 송금) |
| 한국 원화 수취 가상계좌 없음 | 국내 소비자 결제를 Payoneer로 직접 수취 불가 |
| 일본 콘비니 결제 미지원 | GMO PG 등 현지 PG 연동과 병행 필요 |
| 환전 수수료 2~3.5% | Stripe Connect 대비 환전 비용 높을 수 있음 |

### 6.3 셀메이트CM 활용 방안

**적합한 활용 시나리오:**
- 셀메이트CM 글로벌 셀러(한국·일본·동남아 등)에 대한 플랫폼 **정산 도구**로 활용
- 소비자 결제는 GMO PG / 이니시스 / 토스페이먼츠로 수취, 셀러 정산은 Payoneer API로 자동 분배
- 셀메이트CM가 PG 면허 없이도 Payoneer를 통해 글로벌 셀러 정산 가능한 법적 우회 경로 검토 가능

**적합하지 않은 시나리오:**
- 일본 콘비니 결제, 한국 카카오페이 등 현지 소비자 결제 수취 (별도 PG 필요)
- 소규모 셀러 대상 실시간 미시 정산 (Payoneer는 배치 정산에 적합)

---

## 7. Stripe Connect vs Payoneer for Platforms 비교

| 비교 항목 | Stripe Connect | Payoneer for Platforms |
|---------|--------------|----------------------|
| 소비자 결제 수취 | ✅ 가능 (신용카드, 일부 현지 결제) | ❌ 불가 (플랫폼→셀러 송금 전용) |
| 한국 셀러 정산 | ❌ 한국 Connected Account 미지원 | ✅ 가능 |
| 일본 셀러 정산 | ✅ 가능 | ✅ 가능 |
| 동남아 셀러 정산 | ✅ 일부 국가 | ✅ 광범위 지원 |
| 마켓플레이스 수수료 분리 | ✅ Application Fee | ✅ Payout API |
| 플랫폼 면허 요건 | 국가별 상이 | 국가별 상이 |
| 기술 복잡도 | 높음 | 중간 |
| 환전 수수료 | 낮음 (1~1.5%) | 높음 (2~3.5%) |
| 한국 법인 기반 플랫폼 사용 | 제한적 | 가능 |

---

## 8. 결론 및 권고

Payoneer는 셀메이트CM의 **글로벌 셀러 정산 보완 도구**로 활용 가능성이 있다. 특히 Stripe Connect가 지원하지 않는 한국 셀러 정산을 Payoneer로 처리하는 혼합 구조를 검토할 수 있다.

**권고 구조:**
- 일본 소비자 결제: GMO PG (셀메이트 일본 법인 직접 계약) → 셀러 직접 정산
- 한국 소비자 결제: 이니시스/토스페이먼츠 → 셀러 직접 정산
- 글로벌 셀러 정산 보완 도구: Payoneer for Platforms API 연동 검토 (Phase 2)

> ⚠️ **미결 조사 항목**: Payoneer for Platforms의 한국 법인 플랫폼 계약 조건, 최소 거래량 요건, PG 면허 이슈 우회 가능 여부 → 법무 검토 및 Payoneer 파트너십 팀 직접 문의 필요

---

## 9. 플랫폼 마진 수취 구조 분석

**조사 기준일**: 2026-03-18
**조사 출처**: Payoneer 공식 문서, Payoneer 개발자 문서, 복수의 Stripe vs Payoneer 비교 분석 자료

---

### 9.1 Payoneer의 사업 모델 분류

Payoneer는 **PSP(Payment Service Provider) + 크로스보더 정산 플랫폼**의 혼합 구조다. 단순 PG(Payment Gateway)가 아니다.

| 분류 기준 | 설명 |
|---------|------|
| PG (Payment Gateway) | 결제 데이터 전송 통로 역할만 수행 — Payoneer는 이를 초과 |
| PSP (Payment Service Provider) | 머천트 계좌 + 게이트웨이 + 정산까지 원스톱 제공 — Payoneer 해당 |
| 크로스보더 정산 플랫폼 | B2B 국제 송금·수취·환전·가상계좌 특화 — Payoneer 핵심 포지션 |
| Payment Aggregator | 인도에서 2026년 1월 PA-CB(Payment Aggregator Cross-Border) 인가 취득 |

**결론**: Payoneer는 PG가 아닌 **크로스보더 특화 PSP/Payment Aggregator**다. 소비자 결제(카드, 콘비니 등) 처리보다 **B2B 기업 간 정산·송금** 특화.

---

### 9.2 Payoneer가 플랫폼 마진 수취를 지원하는가?

**핵심 발견: Stripe Connect와 구조적으로 다르다.**

| 항목 | Stripe Connect | Payoneer for Platforms |
|-----|--------------|----------------------|
| 플랫폼 마진 수취 방식 | `application_fee_amount` — 거래당 플랫폼 수수료 자동 차감 | **없음** — 플랫폼이 수동으로 분배 금액을 직접 계산 |
| 수수료 분리 자동화 | ✅ API 레벨에서 자동 처리 | ❌ 플랫폼이 직접 금액 조정 후 Payout API 호출 |
| 셀러 서브머천트 구조 | ✅ Connected Account — 셀러별 자동 KYC/온보딩 | ✅ 셀러 Payoneer 계좌 연동 방식 |
| 마진 리포팅 | ✅ Stripe 마진 리포트 제공 | ❌ 자체 구현 필요 |
| 네이티브 플랫폼 수수료 | ✅ 지원 | ❌ **미지원** |

**Payoneer for Platforms의 실제 작동 방식:**
```
소비자 결제 수취 (별도 PG 사용)
    │
    ▼
플랫폼이 총액을 수취
    │
    ├── 플랫폼이 수수료를 직접 차감 (자체 계산)
    │
    ▼
Payout API로 셀러에게 잔액 송금
```
즉, 플랫폼이 "마진을 얼마 떼고 셀러에게 얼마 줄지"를 **직접 계산한 뒤** Payoneer API에 송금 금액만 넘기는 구조다. Stripe Connect처럼 API가 자동으로 수수료를 분리·정산하는 기능은 **없다**.

---

### 9.3 Payoneer Checkout: 소비자 결제 처리 가능 여부

Payoneer는 자사 Checkout 솔루션(구 Optile 인수 기반)을 통해 소비자 결제를 제한적으로 지원한다.

| 항목 | 내용 |
|------|------|
| 카드 결제 | 신용·직불카드 수취 가능 (3.2% + $0.49/건) |
| 통화 환전 | EUR/USD 무환전, 비EUR·USD 통화는 +1.5% 환전 수수료 |
| 지원 지역 | 글로벌이지만 일본 콘비니·한국 간편결제 미지원 |
| 마켓플레이스 플랫폼 수수료 분리 | **공식 미지원** — 플랫폼이 직접 분배 금액 산정 필요 |

Payoneer Checkout은 **단일 셀러가 소비자에게 결제 받는 도구**로 설계되었다. 마켓플레이스가 여러 셀러를 대신해 결제 받고 자동으로 수수료를 분리하는 Stripe Connect형 다자간(multi-party) 구조는 네이티브로 제공하지 않는다.

---

### 9.4 Payoneer를 PG로 쓰는 경우 vs. 정산 도구로만 쓰는 경우

| 구분 | PG 대체 활용 | 정산 도구 활용 |
|-----|------------|-------------|
| 결제 흐름 | 소비자 → Payoneer Checkout → 셀러 | 소비자 → 별도 PG → 셀메이트CM → Payoneer Payout API → 셀러 |
| 한국 소비자 결제 | ❌ 카카오페이·이니시스 등 미지원 | ✅ 이니시스/토스 처리 후 정산에 활용 |
| 일본 소비자 결제 | ❌ 콘비니·Pay-easy 미지원 | ✅ GMO PG 처리 후 정산에 활용 |
| 플랫폼 수수료 자동 분리 | ❌ | ❌ (모두 수동 계산) |
| 적합한 쓰임새 | 디지털재화 글로벌 판매 (제한적) | 해외 셀러 정산 보완 도구 |

**셀메이트CM에 실질적인 활용 경우**: Payoneer는 **정산 도구** 역할만 수행한다. 소비자 결제 수취는 별도 PG(이니시스, GMO 등)가 반드시 필요하며, Payoneer는 수취 이후 셀러에게 분배하는 마지막 단계에서만 활용된다.

---

### 9.5 Stripe Connect vs Payoneer — 셀메이트CM 입장 비교

| 비교 항목 | Stripe Connect | Payoneer for Platforms |
|---------|--------------|----------------------|
| 플랫폼 마진 자동 수취 | ✅ application_fee_amount API | ❌ 수동 계산 후 잔액만 Payout |
| 한국 셀러 Connected Account | ❌ **미지원** | ✅ 가능 |
| 일본 셀러 정산 | ✅ 가능 | ✅ 가능 |
| 소비자 결제 수취 | ✅ 카드, 일부 현지 결제 | ❌ (Checkout는 제한적) |
| 다자간 자동 분배 | ✅ 네이티브 지원 | ❌ API 커스텀 구현 필요 |
| 환전 수수료 | 낮음 (1~1.5%) | 높음 (2~3.5%) |
| 기술 구현 난이도 | 높음 (Connected Account 온보딩) | 중간 (Payout API 연동) |
| 한국 법인 플랫폼 사용 | 제한적 | 가능 |
| 라이선스 부담 | 국가별 상이 | 국가별 상이 |

**핵심 차이**: Stripe Connect는 **플랫폼이 셀러 거래에서 자동으로 수수료를 수취**할 수 있는 구조를 API로 제공하지만, Payoneer는 이 기능이 없다. 플랫폼이 직접 수수료를 계산하고 셀러 Payout 금액을 조정해야 한다.

---

### 9.6 셀메이트CM 활용 시사점

**발견 1 — Payoneer는 "정산 도구"이지 "마진 수취 인프라"가 아니다**
Stripe Connect처럼 플랫폼이 셀러 거래에서 자동으로 수수료를 뽑아내는 구조를 Payoneer는 제공하지 않는다. 수수료 분리 로직은 셀메이트CM 백엔드에서 자체 구현해야 한다.

**발견 2 — Payoneer의 진짜 강점은 한국 셀러 정산**
Stripe Connect가 지원하지 않는 한국 셀러(KRW 정산)를 처리할 수 있는 현실적 경로다. 혼합 구조(소비자 결제는 Stripe/GMO, 한국 셀러 정산은 Payoneer)가 유효하다.

**발견 3 — 플랫폼 마진 수취 로직은 자체 구현 필요**
셀메이트CM가 Payoneer를 통해 마진을 수취하려면, 결제 수취 금액에서 수수료를 차감한 뒤 잔액만 Payoneer Payout API로 셀러에게 보내는 구조를 직접 구현해야 한다. (자동화 가능하나 Stripe Connect보다 구현 복잡도 높음)

**발견 4 — Payoneer Checkout은 셀메이트CM 핵심 시장에 부적합**
일본 콘비니 결제, 한국 카카오페이·이니시스 등 로컬 결제 수단을 지원하지 않으므로, 소비자 결제 PG로는 활용 불가. 정산 단계에서만 의미 있다.

**권고 포지셔닝:**
- Payoneer = 한국 셀러 정산 보완 도구 (Phase 2 검토)
- 플랫폼 수수료 로직 = 셀메이트CM 백엔드 자체 구현 (Stripe Connect 방식 모방)
- 소비자 결제 = 이니시스(한국) + GMO PG(일본) 계속 유지

> ⚠️ **추가 조사 필요**: Payoneer for Platforms 파트너 계약 시 수수료 협상 여지(고거래량 할인), 한국 전자금융업 등록 없이 정산 중개 가능 여부에 대한 법무 확인 필요.

**참고 출처:**
- [Payout Solution for Marketplaces | Payoneer](https://www.payoneer.com/marketplace/)
- [Payoneer API Integration for Marketplaces](https://www.payoneer.com/resources/business/payoneer-integration-api-marketplace-solutions/)
- [Checkout fees - Payoneer Checkout Docs](https://checkoutdocs.payoneer.com/docs/fees-in-checkout)
- [Stripe Connect vs Payoneer — whop.com](https://whop.com/blog/stripe-connect/)
- [Stripe vs Payoneer: Best Choice for Global Payments in 2026 — xflowpay](https://www.xflowpay.com/blog/stripe-vs-payoneer)
- [Payoneer vs Stripe — Wise US](https://wise.com/us/blog/payoneer-vs-stripe)
- [Payoneer Reports FY2025 Financial Results — PR Newswire](https://www.prnewswire.com/news-releases/payoneer-reports-fourth-quarter-and-full-year-2025-financial-results-302697783.html)
- [Payoneer Business Model — Vizologi](https://vizologi.com/business-strategy-canvas/payoneer-business-model-canvas/)
