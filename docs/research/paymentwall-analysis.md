# Paymentwall 분석 [8-4]

> 조사일: 2026-03-06 | 목적: 누리메이트 글로벌 결제 전략 검토

---

## 서비스 개요

| 항목 | 내용 |
|------|------|
| 설립 | 2010년 4월 |
| 창업자 | Honor Gunday, Vladimir Kovalyov |
| 본사 | 미국 샌프란시스코 |
| 글로벌 오피스 | 16개 (서울, 도쿄 포함) |
| 연매출 | $75M (2025년 기준) |
| 직원 수 | 약 201명 |
| 가입 판매자 | 250,000+ |

**포지셔닝:** "글로벌 로컬 결제 전문 플랫폼" — 200개국 이상, 150~190개 이상 로컬 결제수단 지원을 핵심 경쟁력으로 내세우는 B2B 결제 솔루션. 초기에는 게임/소셜 커머스 중심으로 시작했으나 현재는 SaaS, 여행, 이커머스 전반으로 확장.

**역사적 배경:**
- 2010: Facebook 게임 회사의 글로벌 수익화 지원 목적으로 창업
- 2011: Facebook 외부 결제 제공 금지로 인해 일반 온라인 게임·데이팅 서비스로 피벗
- 2018: 게임 전문 결제 플랫폼 Terminal3를 별도 분사
- 2025: NihonPay(일본 전문), PayAlto(글로벌 로컬) 등 전문 플랫폼 라인업 출시

---

## Stripe 대비 포지셔닝

| 구분 | Stripe | Paymentwall |
|------|--------|-------------|
| 핵심 강점 | 개발자 경험, API 품질, 선진국 시장 | 로컬 결제 커버리지, 신흥국 진출 |
| 시장 점유율 | 압도적 1위 (Top 1M 사이트 기준) | 틈새 시장 집중 |
| 주요 고객 | 스타트업~대기업 전반 | 게임, SaaS, 이커머스 대기업 |
| 설립 목적 | 카드 결제 인프라 단순화 | 신흥국 로컬 결제 접근성 |
| 지원 국가 | 47개국 (직접 사업자 등록 기준) | 200개국+ (파트너십 기반) |
| 결제수단 수 | 수십 종 (주요국 집중) | 150~190+ (로컬 특화) |
| 개발 난이도 | 낮음 (문서화 우수) | 중간 (지역별 설정 필요) |
| 브랜드 인지도 | 매우 높음 | 업계 내 인지도 수준 |

**핵심 차별화:** Stripe는 "단일 API로 글로벌 카드 결제"에 강하고, Paymentwall은 "카드가 주류가 아닌 시장(아시아, 중남미, 아프리카)"의 로컬 결제수단 통합에 강하다. 양사는 경쟁보다는 상호 보완적인 포지션을 갖는다.

---

## 지원 국가 및 결제 수단

- **지원 국가:** 200개국 이상
- **결제 수단:** 150~190가지 이상 (e-wallet, 은행이체, 선불카드, 현금, 신용카드 포함)
- **지원 언어:** 30개 이상

### 한국 결제 수단 지원

Paymentwall은 한국 결제를 **공식적으로 완비** 하고 있으며, 별도 법인 없이도 수취 가능.

| 결제수단 | 지원 여부 | 비고 |
|---------|----------|------|
| 카카오페이 | 지원 | 월 활성 사용자 2,500만+ |
| 네이버페이 | 지원 | 카드/계좌 연동 방식 |
| 토스페이 | 지원 | 2,000만+ 사용자 |
| 페이코 | 지원 | 3사 동시 글로벌 공개 |
| 한국 신용/체크카드 (KRW) | 지원 | 로컬 카드 처리 |
| 한국 계좌이체 | 지원 | 주요 은행 포함 |

> 출처: "KakaoPay, Toss, and Payco are now available globally via Paymentwall" (공식 블로그)

**비교 — Stripe의 한국 지원:**
Stripe도 KakaoPay, Naver Pay를 공식 지원(2023년 이후)하나, Paymentwall 대비 로컬 커버리지가 좁고 한국 법인 없이 수취 가능한 결제수단 종류가 제한적.

### 일본 결제 수단 지원

Paymentwall은 2025년 **NihonPay** (일본 전용 플랫폼)를 출시하며 일본 시장을 강화함.

| 결제수단 | 지원 여부 | 비고 |
|---------|----------|------|
| 콘비니 (Konbini) | 지원 | 7-Eleven, Lawson, FamilyMart 등 55,000곳+ |
| PayEasy (계좌이체) | 지원 | 온라인뱅킹·ATM·우체국 |
| PayPay | 지원 (NihonPay) | 6,700만+ 사용자, 2025년 통합 |
| JCB | 지원 | 일본 주요 카드 브랜드 |
| Visa / Mastercard | 지원 | 글로벌 카드 |
| BitCash, WebMoney JP, MINT | 지원 | 선불카드 |

> 출처: Paymentwall 공식 블로그 (NihonPay 런칭, 2025년 6월)

**비교 — Stripe의 일본 지원:**
Stripe도 Konbini(34,000개 편의점), Furikomi(계좌이체)를 지원하며 일본 투자를 강화 중. 단, PayPay 직접 통합은 공식 확인 어려움. 일본 법인(Stripe Japan K.K.) 운영으로 현지 규제 대응력은 Stripe가 우세.

### 글로벌 로컬 결제 커버리지

| 지역 | 주요 지원 결제수단 |
|------|-----------------|
| 동남아 (인도네시아) | GoPay, OVO, Sakuku, LinkAja, Indomaret, Alfamart, BRI/Mandiri/BCA 계좌이체 |
| 동남아 (말레이시아) | GrabPay Malaysia |
| 중국 | Alipay, WeChat Pay |
| 중남미 (브라질) | Boleto, PIX 계열 |
| 아프리카 | M-Pesa 등 모바일 머니 |
| 유럽 | SEPA, Sofort, iDEAL 등 |

---

## 수수료 구조

Paymentwall은 수수료를 공개적으로 고정 게시하지 않고 결제수단·국가·리스크 수준에 따라 개별 협상하는 모델을 기본으로 함. 공개된 참고 수치:

| 항목 | 내용 |
|------|------|
| 기본 구조 | 2% + 결제수단별 추가 수수료 |
| 미국 카드 결제 | 2.9% + $0.30 |
| 브라질 은행이체 | 5.5% + $0.25 |
| e-Wallet 류 | 2~7% 범위 |
| 키오스크/현금 | 5~15% |
| 선불카드 | 7~20% |
| 월 기본료 | $100 (비즈니스 계정) |
| 건당 고정 수수료 | $0.10 (기본) |
| 환전 수수료 | 별도 (통화별 변동) |

**Stripe 비교:** Stripe는 월 고정 기본료 없이 2.9% + $0.30 (미국 카드 기준)이며 투명한 공개 요금제가 강점. Paymentwall은 로컬 결제수단 다양성 대신 수수료 복잡성과 월 기본료가 부담.

---

## WIX 파트너십

- **파트너십 내용:** Wix 내 공식 결제 제공업체(Payment Provider)로 등록
- **연동 방식:** 코딩 불필요, Wix 앱 설정에서 API 키 입력만으로 활성화
- **제공 결제수단:** 190개+ 로컬 결제수단 이용 가능
- **보안:** PCI DSS Level-1, 3D Secure 지원
- **지원 버전:** 최신 Wix 버전 모두 대응

**전략적 의미:** Wix가 Paymentwall을 채택한 이유는 자체 Wix Payments가 커버하지 못하는 신흥 시장(아시아, 중남미, 아프리카) 고객을 위한 보완재로 활용하기 위함. 2025년 7월에는 PayPal과 추가 전략적 파트너십도 체결하여 복수 결제 파트너 전략을 구사 중.

---

## 기업 평판 및 주요 고객사

**주요 고객사:**
- LG전자, 삼성전자
- Shopify
- Kakao Games
- Tencent
- Wargaming (게임)
- Kigo

**평판 — 양극화:**

| 플랫폼 | 평점 | 비고 |
|--------|------|------|
| G2 | 4.3/5 (5건) | B2B 기업 사용자 위주 |
| Trustpilot | 낮음 | 소비자 불만 다수 |
| Sitejabber | 1.7/5 (40건) | 검증 절차·CS 불만 |
| PissedConsumer | 1.2/5 (55건) | 결제 보류·지연 불만 |

**평판 요약:** B2B 판매자(기업) 입장에서는 로컬 결제 커버리지에 만족도 높으나, 소비자(최종 결제자) 입장에서는 사기 방지를 위한 문서 요청 과다, CS 응답 지연이 주요 불만. 고위험 비즈니스 모델(게임, 가상 아이템)에 대한 높은 심사 기준이 소비자 리뷰 점수를 낮추는 구조적 원인.

---

## 누리메이트 도입 시 장단점 평가

| 항목 | Stripe | Paymentwall |
|------|--------|-------------|
| 한국 결제 | 부분 지원 (KakaoPay, NaverPay) | 완비 (카카오·네이버·토스·페이코·계좌이체) |
| 일본 결제 | Konbini, Furikomi 지원 / PayPay 불명확 | Konbini, PayEasy, PayPay, JCB 지원 (NihonPay) |
| 동남아 결제 | GrabPay, 일부 e-wallet 지원 | GoPay, OVO, GrabPay 등 광범위 |
| 수수료 | 투명, 단순 (2.9%+$0.30 기본) | 복잡, 월 $100 기본료 + 수단별 변동 |
| 도입 복잡도 | 낮음 (API 문서 우수, 개발자 친화) | 중간 (지역별 설정, 온보딩 필요) |
| 브랜드 신뢰도 | 매우 높음 | 업계 수준 (소비자 인지도 낮음) |
| 한국 법인 필요 여부 | 불필요 | 불필요 |
| 소비자 평판 | 높음 | 낮음 (CS 이슈) |
| 적합 시장 | 미국·유럽·주요 선진국 | 아시아·중남미·아프리카 신흥국 |

---

## 결론 및 추천

### 요약

Paymentwall은 Stripe가 약한 아시아 신흥국 로컬 결제(한국 3대 페이, 일본 편의점결제·PayPay, 동남아 e-wallet)를 광범위하게 지원하는 점에서 누리메이트의 아시아 확장 전략에 유의미한 옵션이다.

### 추천 시나리오

**단독 도입 (Paymentwall만 사용):**
- 적합 조건: 아시아 신흥국 중심 사업, 초기 비용 부담 감내 가능
- 리스크: 소비자 CS 품질, 월 $100 기본료, 수수료 복잡성

**Stripe + Paymentwall 병행 (권장):**
- Stripe: 미국·유럽·글로벌 카드 결제 담당
- Paymentwall: 한국·일본·동남아 로컬 결제 담당
- 장점: 각 플랫폼의 강점 활용, 리스크 분산
- 단점: 이중 관리 비용, 정산 복잡성

**Wix 사이트 활용 시:**
- Wix 공식 파트너이므로 코딩 없이 즉시 연동 가능 → 초기 MVP 검증에 적합

### 최종 의견

누리메이트가 한국·일본·동남아를 핵심 시장으로 설정한다면, Paymentwall의 로컬 결제 커버리지는 Stripe 단독으로는 채울 수 없는 공백을 메워준다. 단, 소비자 CS 품질 이슈와 수수료 복잡성을 감안해 **Stripe를 주력, Paymentwall을 아시아 로컬 결제 보완재로 병행하는 전략**이 현실적이다.

---

## 플랫폼 마진 계약 가능 여부 [4-18]

> 조사일: 2026-03-10 | 추가 섹션

---

### 1. Paymentwall 플랫폼/마켓플레이스 계약 모델 존재 여부

**결론: Paymentwall은 공개된 공식 플랫폼 마진/마켓플레이스 파트너 프로그램이 제한적이다.**

Paymentwall은 자사 파트너 채널을 통해 Reseller, White-label 유사 구조를 운영하고 있으나, Stripe Connect처럼 **API 레벨에서 플랫폼이 마진을 수취하고 셀러에게 자동 분배하는 마켓플레이스 전용 기능(Application Fee, Split Payout)은 공식적으로 제공하지 않는다.**

| 항목 | 내용 |
|------|------|
| 공식 마켓플레이스 API | 미제공 (Stripe Connect 수준의 연결 계정 구조 없음) |
| 파트너/리셀러 프로그램 | 비공개 협상 기반 존재 가능성 있음 (공개 페이지 없음) |
| White-label 솔루션 | 일부 문의 기반 커스텀 계약으로 제공 가능성 있음 |
| 주요 파트너 유형 | 대형 플랫폼(Wix, Shopify) 등과 결제 제공업체(Payment Provider)로 등록 |
| API 구조 | 단일 판매자 기준의 Widget / API 구조 (멀티 셀러 자동 분배 기능 없음) |

> Paymentwall은 250,000+ 가맹점을 보유한 B2B PG이나, 마켓플레이스 플랫폼이 여러 셀러의 결제를 중개하고 수수료를 자동 분배하는 **Connect형 플랫폼 마진 구조**는 공식 지원하지 않는 것으로 파악된다. 플랫폼 마진은 플랫폼이 수취한 결제 금액에서 수동으로 셀러에게 정산하는 구조로만 구현 가능하다.

---

### 2. 플랫폼 사업자 입장에서의 마진 수취 구조

Paymentwall 구조에서 플랫폼이 마진을 수취하려면 아래와 같은 **수동 구조**를 사용해야 한다:

```
소비자 결제 (Paymentwall 통해 플랫폼 계정으로 수취)
      ↓
플랫폼이 전체 금액 수취 (플랫폼 계정)
      ↓
플랫폼이 수수료 차감 후 셀러에게 별도 정산 (수동/배치 처리)
```

| 항목 | Paymentwall 구조 | Stripe Connect 구조 |
|------|-----------------|---------------------|
| 자동 분배 | 불가 | 가능 (Application Fee + Payout) |
| 플랫폼 마진 수취 | 전체 수취 후 수동 분배 | Application Fee로 자동 공제 |
| 셀러 정산 자동화 | 불가 (별도 시스템 구축 필요) | 가능 (Connected Account 자동 Payout) |
| 셀러 KYC | 플랫폼이 별도 처리 | Stripe가 Express/Custom 온보딩 처리 |
| 자금 보유 주체 | 플랫폼 | Stripe (에스크로 방식) |

**결론:** Paymentwall을 마켓플레이스 구조로 사용하면, 플랫폼이 자금을 일시 보유 후 셀러에게 별도 정산하는 구조가 되며 이는 **한국 전자금융거래법상 전자지급결제대행업(PG업) 등록 의무를 유발할 수 있다.**

---

### 3. Stripe Connect의 플랫폼 마진 구조와 비교

| 비교 항목 | Paymentwall | Stripe Connect |
|-----------|-------------|----------------|
| 플랫폼 마진 API | 없음 (수동 정산) | Application Fee (자동) |
| 셀러 자동 정산 | 없음 | Connected Account Payout (자동) |
| 마켓플레이스 전용 기능 | 없음 | 있음 (Destination Charge, Separate Charge & Transfer) |
| 셀러 KYC 책임 | 플랫폼 | Stripe (Express/Custom 온보딩) |
| 커버 국가 | 200개국+ (셀러 결제 수취) | 46개국 (사업자 등록 기준) |
| 한국 셀러 정산 | 가능 (Paymentwall 미국 계정으로 수취 후 송금) | 불가 (한국 Connected Account 생성 불가) |
| 일본 셀러 정산 | 가능 | 가능 (Connected Account 생성 가능) |
| 동남아 로컬 결제 | 강점 (GoPay, OVO 등) | 약점 (베트남·말레이시아 미지원) |

**핵심 차이:** Stripe Connect는 플랫폼 마진 수취·셀러 정산 자동화·KYC를 API 레벨에서 해결해 주는 반면, Paymentwall은 이 기능이 없어 **플랫폼 스스로 정산 시스템을 구축해야 한다.** 단, Paymentwall은 Stripe Connect가 커버하지 못하는 한국·동남아 로컬 결제수단에 강하다.

---

### 4. 계약 주체 요건

#### Paymentwall 계약 요건 (플랫폼 사업자 기준)

| 항목 | 요건 |
|------|------|
| 법인 소재지 | 미국, 영국, 싱가포르 등 지원 국가 법인 (한국 법인도 일부 가능) |
| 최소 거래량 | 명시적 최소 기준 없음, 단 월 $100 기본료 발생 |
| 심사 | 사업 모델 심사, 고위험 업종(도박·성인·암호화폐) 별도 심사 |
| White-label 계약 | 별도 협의 필요 (공개 프로그램 없음) |
| PCI DSS | Level-1 준수 (가맹점은 별도 인증 불필요) |

#### Stripe Connect 계약 요건 (플랫폼 사업자 기준)

| 항목 | 요건 |
|------|------|
| 법인 소재지 | Stripe 지원 46개국 중 하나 (한국 불포함) |
| 최소 거래량 | 없음 |
| 심사 | 사업 모델 검토, 플랫폼 계정 활성화 |
| Application Fee 수취 | API 파라미터로 자동 설정 |

---

### 5. Paymentwall 지원 불가 시 대체 글로벌 PG 비교

플랫폼 마진 수취와 멀티 셀러 자동 정산이 모두 필요하고, Paymentwall이 이를 지원하지 않을 경우 아래 대안이 있다.

| PG/플랫폼 | 플랫폼 마진 지원 | 아시아 로컬 결제 | 한국 셀러 정산 | 일본 셀러 정산 | 특징 |
|-----------|-----------------|-----------------|---------------|---------------|------|
| **Stripe Connect** | 완전 지원 (Application Fee) | 제한적 | 불가 | 가능 | 개발자 경험 최고 |
| **Adyen for Platforms (MarketPay)** | 완전 지원 | 광범위 지원 | 제한적 | 가능 | 대기업 수준 최소 거래량 |
| **Checkout.com Marketplaces** | 지원 | 아시아 일부 지원 | 제한적 | 가능 | 협상 기반, 대형 거래량 필요 |
| **Rapyd** | 부분 지원 | 동남아 강점 | 가능 (Wallet 방식) | 가능 | 150개국 로컬 결제 통합 |
| **Payoneer** | 부분 지원 (Mass Payout) | 아시아 커버 | 가능 | 가능 | 셀러 정산 특화, 마켓플레이스 서비스 |

#### Adyen for Platforms 상세

- **구 명칭:** MarketPay → 현재 Adyen for Platforms
- **기능:** 결제 수취, 수수료 분리(Split Payment), 셀러 자동 정산, KYC 대리 처리
- **아시아 지원:** 일본·싱가포르·홍콩·호주·뉴질랜드 등 지원. 한국·동남아 일부 제한
- **최소 거래량:** 대기업/고성장 스케일업 대상 (최소 월 거래 100만 달러 이상 권고)
- **수수료:** 인터체인지++ 모델 (투명한 구조), 건당 처리비 + 인터체인지

#### Rapyd 상세

- **마켓플레이스 기능:** Rapyd Collect + Disburse 조합으로 플랫폼 마진 구조 구현 가능
- **아시아 커버리지:** 인도네시아, 태국, 베트남, 말레이시아, 필리핀 등 동남아 로컬 결제 지원
- **한국 지원:** 카카오페이, 네이버페이 등 일부 지원
- **셀러 정산:** Rapyd Wallet 기반의 자동 분배 가능

#### 누리메이트 권장 구조

| 결제 유형 | 권장 PG | 이유 |
|-----------|---------|------|
| 글로벌 카드 + 일본 셀러 정산 | Stripe Connect | 마진 자동화, 일본 셀러 온보딩 가능 |
| 한국 로컬 결제 수취 | Paymentwall 또는 Eximbay | 한국 결제수단 완비, 해외 법인으로 수취 가능 |
| 한국 셀러 정산 | Payoneer 또는 직접 은행 송금 | Stripe Connect 미지원, 대안 필요 |
| 동남아 로컬 결제 | Paymentwall + Xendit | 로컬 결제수단 최대 커버리지 |
| 대규모 마켓플레이스 성장 후 | Adyen for Platforms | 완전한 플랫폼 마진 자동화 |

---

## 출처

- [Paymentwall - Wikipedia](https://en.wikipedia.org/wiki/Paymentwall)
- [Paymentwall 공식 홈페이지 - 결제수단](https://www.paymentwall.com/en/payment-methods)
- [KakaoPay, Toss, Payco 글로벌 지원 발표](https://blog.paymentwall.com/news/kakaopay-toss-and-payco-are-now-available-globally-via-paymentwall)
- [Paymentwall 한국 결제수단](https://www.paymentwall.com/en/payment-methods/south-korea)
- [Paymentwall 일본 결제수단](https://www.paymentwall.com/en/payment-methods/japan)
- [Paymentwall Konbini 문서](https://docs.paymentwall.com/payment-method/konbini)
- [Paymentwall 일본 시장 진출 블로그](https://blog.paymentwall.com/news/paymentwall-opens-japanese-digital-market-to-international-businesses)
- [GoPay, OVO, Sakuku, LinkAja 인도네시아 통합](https://blog.paymentwall.com/news/gopay-ovo-sakuku-and-linkaja-in-indonesia-are-now-available-globally-via-paymentwall)
- [GrabPay Malaysia 문서](https://docs.paymentwall.com/payment-method/grabpaymalay)
- [Paymentwall 수수료 (CalculateFees)](https://info.calculatefees.com/processor/paymentwall)
- [Paymentwall 가격 정책](https://www.paymentwall.com/en/pricing)
- [Wix + Paymentwall 파트너십 블로그](https://blog.paymentwall.com/news/paymentwall-wix-partnership)
- [Wix 공식 헬프: Paymentwall 연동 가이드](https://support.wix.com/en/article/connecting-paymentwall-as-a-payment-provider)
- [Paymentwall G2 리뷰](https://www.g2.com/products/paymentwall/reviews)
- [Stripe Konbini 지원](https://docs.stripe.com/payments/konbini)
- [Stripe KakaoPay 지원](https://docs.stripe.com/payments/kakao-pay/accept-a-payment)
- [Stripe NaverPay 지원](https://docs.stripe.com/payments/naver-pay/accept-a-payment)
- [Paymentwall 글로벌 전문 플랫폼 런칭 (NihonPay 포함)](https://blog.paymentwall.com/news/paymentwall-launches-global-suite-of-specialized-payment-platforms-to-transform-cross-border-commerce)
- [Paymentwall vs Stripe 비교 (SpotSaaS)](https://www.spotsaas.com/compare/paymentwall-vs-stripe-payments)
- [Paymentwall Crunchbase](https://www.crunchbase.com/organization/paymentwall)
