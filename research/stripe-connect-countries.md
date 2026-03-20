# Stripe Connect 정산 가능 국가 전수 조사 [4-19]

> 조사일: 2026-03-10 | 목적: 누리메이트 글로벌 결제 인프라 설계

---

## 1. Stripe Connect 개요 및 계정 유형

Stripe Connect는 플랫폼·마켓플레이스가 셀러(판매자)에게 정산을 수행할 수 있도록 설계된 멀티사이드 결제 인프라다. 계정 유형에 따라 지원 국가 범위가 다르며, 플랫폼 계정 소재지와 Connected Account 소재지 모두 가용 국가 범위에 영향을 준다.

| 계정 유형 | 설명 | 특징 |
|-----------|------|------|
| **Standard** | 셀러가 직접 Stripe 계정을 보유, 플랫폼과 연결 | 셀러가 Stripe 대시보드 독립 접근 가능 |
| **Express** | Stripe가 온보딩·KYC 처리, 간소화된 Express Dashboard 제공 | 플랫폼이 UI를 일부 커스터마이즈 |
| **Custom** | 플랫폼이 온보딩·KYC 전체를 자체 구현, 셀러는 Stripe 대시보드 없음 | 가장 높은 커스터마이즈 자유도, 책임도 최대 |

---

## 2. Stripe Connect 플랫폼 계정 생성 가능 국가 전체 목록

Stripe Connect를 통해 Express 또는 Custom Connected Account를 생성(플랫폼 운영)할 수 있는 국가는 2025년 기준 아래와 같다.

### Express Connected Account 플랫폼 지원 국가 (41개국)

| 지역 | 국가 |
|------|------|
| 북미 | 미국, 캐나다, 멕시코 |
| 유럽 | 영국, 독일, 프랑스, 이탈리아, 스페인, 네덜란드, 벨기에, 스위스, 오스트리아, 덴마크, 스웨덴, 노르웨이, 핀란드, 아일랜드, 포르투갈, 룩셈부르크, 체코, 폴란드, 헝가리, 루마니아, 불가리아, 크로아티아, 슬로바키아, 슬로베니아, 에스토니아, 라트비아, 리투아니아, 몰타, 키프로스, 그리스 |
| 아시아태평양 | 일본, 싱가포르, 홍콩, 호주, 뉴질랜드, 태국* |
| 중동 | UAE* |
| 중남미 | 브라질 |

> *태국·UAE는 Express 플랫폼 계정은 기술적으로 허용되나, 자체 온보딩 불가 — Stripe에 직접 연락 필요.

### Custom Connected Account 플랫폼 지원 국가 (43개국)

Express 지원 국가 전체 포함 + **인도** 추가. 단, UAE·인도·태국은 자체 온보딩 불가, Stripe 직접 문의 필요.

### Standard Connected Account

Standard 계정은 위 플랫폼 지원 국가 외에도, Stripe가 사업자 등록을 지원하는 **46개국 전체**에서 셀러가 자체 Stripe 계정을 보유하고 플랫폼과 연결하는 방식으로 이용 가능하다.

---

## 3. 한국 법인 셀러 정산 가능 여부

### 결론 요약

| 구분 | 가능 여부 | 비고 |
|------|-----------|------|
| 한국 법인이 Stripe 계정 직접 개설 | **불가** | 한국은 Stripe 사업자 등록 미지원 국가 |
| 한국 법인 셀러를 Standard Connected Account로 연결 | **불가** | 한국 법인으로 Stripe 계정 개설 불가 |
| 한국 법인 셀러를 Express Connected Account로 연결 | **불가** | 동일 이유 |
| 한국 법인 셀러를 Custom Connected Account로 연결 | **불가** | 동일 이유 |
| 한국 결제수단(KakaoPay, NaverPay 등)으로 **고객에게 결제 수취** | **가능** | 플랫폼이 지원 국가에 있을 경우 |

### 상세 분석

- **한국(대한민국)은 Stripe 사업자 등록 지원 국가 목록에 포함되지 않는다.** 즉 한국 법인은 Stripe 계정을 직접 개설하거나 Connected Account를 생성할 수 없다.
- 다만 **한국 고객에게 결제를 수취**하는 것은 가능하다. 플랫폼(예: 미국·일본 법인)이 Stripe를 운영하면서 KakaoPay, Naver Pay 등 한국 결제수단을 활성화해 한국 소비자 결제를 처리할 수 있다.
- 한국 셀러에게 정산을 지급하려면 **Stripe Connect 밖에서 처리**해야 한다(예: 한국 은행 계좌로 직접 해외 송금, 토스페이먼츠 등 한국 PG 별도 계약).

### 계정 유형별 가능 여부 비교

| 계정 유형 | 한국 법인 셀러 생성 가능 여부 |
|-----------|-------------------------------|
| Standard | 불가 (Stripe 계정 개설 자체 불가) |
| Express | 불가 |
| Custom | 불가 |

---

## 4. 일본 법인 셀러 정산 가능 여부

### 결론 요약

| 구분 | 가능 여부 | 비고 |
|------|-----------|------|
| 일본 법인이 Stripe 계정 직접 개설 | **가능** | 일본은 완전 지원 국가 |
| 일본 법인 셀러를 Standard Connected Account로 연결 | **가능** | |
| 일본 법인 셀러를 Express Connected Account로 연결 | **가능** | 일본 소재 플랫폼에서 생성 가능 |
| 일본 법인 셀러를 Custom Connected Account로 연결 | **가능** | 일본 소재 플랫폼에서 생성 가능 |

### 상세 분석

- **일본은 Stripe Connect의 완전 지원 국가**다. Stripe Japan K.K.(스트라이프재팬 주식회사)가 현지 법인을 운영하며 현지 금융 규제를 준수한다.
- 일본 법인 기반 플랫폼(또는 미국·EU 등 다른 지원 국가 플랫폼)이 일본 법인 셀러를 Express / Custom Connected Account로 온보딩하는 것이 모두 가능하다.
- 일본 결제수단(Konbini, PayPay, JCB, Furikomi 등) 처리 및 JPY 정산을 포함한 풀스택 지원이 제공된다.

---

## 5. 동남아 주요 타겟 국가 가능 여부

| 국가 | Stripe 사업자 등록 | Connected Account 생성 | 비고 |
|------|-------------------|-----------------------|------|
| 싱가포르 | 가능 | 가능 (Express·Custom 모두) | 완전 지원 |
| 말레이시아 | **불가** | **불가** | 미지원 국가 |
| 태국 | 제한적 | Express·Custom 가능 (단, 자체 온보딩 불가, Stripe 직접 문의 필요) | 제한적 지원 |
| 인도네시아 | 프리뷰(Preview) | 제한적 | 기능 제한 상태 |
| 베트남 | **불가** | **불가** | 미지원 국가 |
| 필리핀 | **불가** | **불가** | 미지원 국가 |
| 캄보디아 | **불가** | **불가** | 미지원 국가 |

### 동남아 요약 평가

- **싱가포르**만 완전 지원. 동남아 지역 허브 전략으로 싱가포르 법인 활용 시 Connect 운영 가능.
- **태국·인도네시아**는 제한적 접근 가능하나 자체 온보딩 불가 또는 Preview 상태.
- **베트남·말레이시아·인도네시아(일반)·필리핀** 등 핵심 동남아 국가 대부분은 Stripe Connect 불가.
- Stripe는 동남아의 모바일 결제(GoPay, GrabPay, TrueMoney 등) 통합에 한계가 있으며, 현지 규제 및 은행 인프라 차이로 진입이 지연되고 있다.

---

## 6. 정산 불가 국가 및 대안 PG 제안

### 주요 미지원/제한 국가

| 국가 | 상태 | 핵심 사유 |
|------|------|-----------|
| 한국 | 미지원 | 현지 금융 규제, 로컬 PG 생태계 강세 |
| 베트남 | 미지원 | 전자결제 규제, 외국 핀테크 제한 |
| 말레이시아 | 미지원 | 현지 라이선스 체계 |
| 인도네시아 | 프리뷰 | Bank Indonesia 규제, 외환 통제 |
| 필리핀 | 미지원 | BSP 규제 |
| 태국 | 제한적 | BOT 규제 |
| 방글라데시 | 미지원 | 외환 규제 |
| 파키스탄 | 미지원 | 외환 규제 |
| 아프리카 대부분 | 미지원 | 인프라·규제 문제 |

### 국가별 대안 PG 제안

| 국가/지역 | 대안 PG/결제 솔루션 | 특징 |
|-----------|---------------------|------|
| 한국 | 토스페이먼츠, KG이니시스, KCP, KSNET | 국내 법인 필요, 한국 결제수단 완비 |
| 한국 (해외 법인 수취) | Paymentwall, Eximbay | 해외 법인으로 한국 결제 수취 가능 |
| 인도네시아 | Midtrans(GoTo), DOKU, Xendit | 로컬 e-wallet·편의점 결제 지원 |
| 베트남 | VNPay, OnePay, MoMo, Xendit | 현지 은행·QR 결제 지원 |
| 말레이시아 | iPay88, MOLPay(Razer), Billplz | FPX(온라인 계좌이체), TNG eWallet |
| 태국 | Omise(2C2P), GBPrimePay, TrueMoney | PromptPay QR, True Money Wallet |
| 필리핀 | DragonPay, PayMongo, GCash (Maya) | GCash, PayMaya 로컬 wallet |
| 동남아 통합 | Xendit, 2C2P, Adyen | 다국 통합 가능, API 통일성 있음 |
| 글로벌 로컬 결제 통합 | Paymentwall, Rapyd | 150~200개 로컬 결제수단 통합 |

---

## 7. Stripe Atlas를 통한 미국 법인 설립

### 개요

Stripe Atlas는 비미국 거주자(외국인)도 미국 Delaware C-Corp 또는 LLC를 온라인으로 설립할 수 있는 서비스다. 누리메이트가 한국·일본이 아닌 **미국 법인 기반으로 Stripe Connect를 운영**하려는 경우의 기반 옵션이다.

### 설립 비용

| 항목 | 금액 |
|------|------|
| Atlas 서비스 기본료 | $500 (1회) |
| 1년차 등록 에이전트 포함 | 기본료에 포함 |
| 2년차부터 등록 에이전트 연간 유지비 | $100/년 |
| Delaware 주정부 신고비 | Atlas 기본료에 포함 |

**특전:** Stripe 제품 크레딧 $2,500 (1년 이내 사용) + Mercury, Xero, AWS 등 $50,000+ 파트너 할인

### 소요 기간

| 단계 | 소요 시간 |
|------|-----------|
| 서류 작성 및 제출 | 수 시간 (온라인) |
| Delaware 주정부 법인 등록 | 약 2 영업일 |
| IRS EIN 발급 (SSN 보유자) | 즉시~수 일 (온라인 빠른 처리) |
| IRS EIN 발급 (외국인, SSN 없음) | **4~8주** (우편 처리) |
| 전체 운영 준비 완료 | SSN 있으면 약 2주, 없으면 4~8주 |

### 설립 요건 및 절차

1. **법인 유형 선택:** Delaware C-Corp (투자 유치 목적) 또는 LLC (세금 유연성 목적)
2. **필수 정보:** 회사명, 사업 내용, 창업자 정보(여권 등 신분증), 주소(미국 주소 불필요), 주주 지분 비율
3. **창업자 국적 무관:** 한국·일본 등 어느 국가 국적자도 설립 가능
4. **미국 주소 불필요:** Delaware 등록 에이전트(Atlas 포함)가 법적 주소 역할
5. **미국 은행 계좌:** Atlas 파트너 Mercury Bank를 통해 설립과 동시에 개설 가능 (SSN 불필요)

---

## 8. 미국 법인 기반 Stripe Connect 운영 시 한국·일본 셀러에 대한 세무·법적 영향

### 8-1. 플랫폼(누리메이트) 관점

미국 Delaware C-Corp으로 Stripe Connect 플랫폼을 운영할 경우:
- 미국 법인세(연방 21%) 납부 의무
- 미국 세무신고 의무 (Form 1120 등)
- 한국·일본에서의 실질 사업장 여부에 따라 **이중 과세 리스크** 존재
- 한·미 조세조약, 일·미 조세조약 적용 검토 필요

### 8-2. 한국 법인 셀러 관점

미국 법인 플랫폼(누리메이트)으로부터 정산을 받는 한국 셀러:

| 항목 | 내용 |
|------|------|
| Stripe Connect 등록 가능 여부 | 한국은 여전히 미지원 → Custom/Express Connected Account 직접 생성 불가 |
| 정산 수취 방법 | 미국 법인에서 한국 법인으로 해외 송금(국제 전신환) 방식으로 정산 |
| 한국 세무 처리 | 외화 수입으로 처리, 환율 차이 익금/손금 산입 |
| 원천징수 | 미국 측에서 한국 법인에 지급 시 원칙적으로 원천징수 없음 (사업 소득 성격) |
| 한국 부가가치세 | 매출 발생 시 부가세 신고 의무 |

> **핵심 한계:** 미국 법인으로 플랫폼을 운영하더라도, 한국 법인 셀러는 Stripe Connected Account로 직접 온보딩이 불가하다. 정산 자체는 별도 은행 송금 또는 Paymentwall·Payoneer 등 대안 수단을 통해야 한다.

### 8-3. 일본 법인 셀러 관점

| 항목 | 내용 |
|------|------|
| Stripe Connect 등록 가능 여부 | **가능** — 일본 법인은 Custom/Express Connected Account 생성 가능 |
| 정산 통화 | JPY 직접 정산 가능 |
| 일본 세무 처리 | 일본 법인세·소비세 신고 의무 |
| 일·미 조세조약 | 사업 소득에 대한 원천징수 면제(고정사업장 없는 경우) |
| LLC vs C-Corp 고려 | LLC는 패스스루 과세 → 일본 법인 셀러가 미국 LLC 지분 보유 시 미·일 양국 과세 이슈 발생 가능. **일본 셀러가 관여된 경우 C-Corp 구조가 더 단순** |

### 8-4. 핵심 세무·법적 리스크 요약

| 리스크 | 내용 | 권고 |
|--------|------|------|
| 이중 과세 | 한국/일본 법인이 미국 플랫폼으로부터 수입 발생 시 양국 과세 가능성 | 조세조약 및 고정사업장 여부 검토 |
| 실질 사업장(PE) 판정 | 한국/일본에서 실질 운영 시 미국 법인이 현지 PE로 인정될 수 있음 | 전문 세무사 자문 필수 |
| 외환 규제 | 한국 외국환거래법상 해외 법인과의 수수료 거래 신고 의무 | 외국환 신고 절차 준수 |
| W-8BEN-E 서류 | 미국 법인이 외국 셀러에게 지급 시 세금 관련 서류 요구 가능 | 초기 온보딩 시 구비 |

---

## 9. 전략적 시사점 (누리메이트)

| 시나리오 | 적합성 | 비고 |
|----------|--------|------|
| 일본 법인 기반 플랫폼 → 일본 셀러 Connect 온보딩 | 최적 | 가장 단순하고 확실한 구조 |
| 미국 법인(Atlas) 기반 플랫폼 → 일본 셀러 Connect 온보딩 | 가능 | 크로스보더 세무 검토 필요 |
| 미국/일본 법인 플랫폼 → 한국 셀러 Connect 온보딩 | 불가 | 대안 정산 수단 필요 |
| 한국 셀러 정산 대안 | Paymentwall, Payoneer, 토스페이먼츠 직계약 | Stripe Connect 외 채널 필요 |
| 동남아 셀러(싱가포르 제외) 정산 | Stripe Connect 불가 | Xendit, 2C2P, Midtrans 등 현지 PG 병행 필수 |

---

## 출처

- [Stripe global availability](https://stripe.com/global)
- [Stripe Connect account types](https://docs.stripe.com/connect/accounts)
- [Stripe Express accounts](https://docs.stripe.com/connect/express-accounts)
- [Stripe Custom accounts](https://docs.stripe.com/connect/custom-accounts)
- [How Many Countries Does Stripe Support in 2026?](https://redstagfulfillment.com/how-many-countries-does-stripe-operate-in/)
- [Countries Available for Stripe Custom Accounts - Stan Store](https://help.stan.store/article/217-countries-available-for-stripe-custom-accounts)
- [Stripe feature availability by country](https://support.stripe.com/questions/stripe-feature-availability-by-country)
- [Stripe Atlas 공식 페이지](https://stripe.com/atlas)
- [Stripe Atlas 설립 가이드](https://docs.stripe.com/atlas/signup)
- [Stripe Atlas Review - Rapidr](https://rapidr.io/blog/stripe-atlas/)
- [Stripe Atlas Accounting Guide - HubiFi](https://www.hubifi.com/blog/stripe-atlas-accounting-guide)
- [How to accept payments in South Korea - Stripe](https://stripe.com/resources/more/payments-in-south-korea)
- [Cross-border ecommerce from Japan to South Korea - Stripe](https://stripe.com/resources/more/cross-border-ecommerce-in-south-korea-from-japan)
- [Stripe Connect cross-border payouts](https://docs.stripe.com/connect/cross-border-payouts)
- [Global Payouts 13 new countries - Stripe Changelog](https://docs.stripe.com/changelog/clover/2025-12-15/cross-border-payouts-new-countries)
- [Korea Withholding Taxes - PwC](https://taxsummaries.pwc.com/republic-of-korea/corporate/withholding-taxes)
- [Stripe unsupported countries guide - Foundeck](https://foundeck.com/blog/stripe-for-unsupported-countries/)
