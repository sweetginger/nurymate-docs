# 누리메이트(Nurymate) 전략 개요서

> 작성일: 2026-04-13 | 버전: v1.2

---

## 한 줄 정의

**누리메이트는 누구나 30분 만에 쇼핑몰을 열고, 복잡한 설정 없이 글로벌 시장을 하나의 플랫폼으로 운영하는 차세대 헤드리스 이커머스 SaaS입니다.**

AI가 상품 등록·운영 이슈·분석을 자동으로 처리해 운영이 쉽고 빠르며, 글로벌 현지 결제수단을 로컬망으로 제공합니다.

---

## 셀메이트의 전략적 배경

누리메이트는 단독 제품이 아니라 **셀메이트의 사업 범위 확장** 맥락에서 탄생했습니다.

### 기존 셀메이트의 접점 구조

```
구매자 → [판매 채널] → 주문 발생 → OMS → 셀메이트 ← 판매자
                                              ↑
                                    셀메이트의 접점 시작점
```

기존 셀메이트는 **주문이 발생한 이후 OMS 영역부터** 판매자와 접점을 가졌습니다. 구매자는 셀메이트의 사업 범위 밖에 있었고, 수익은 판매자 대상 서비스에만 의존했습니다.

### 누리메이트 도입 후 접점 확장

```
구매자 → [누리메이트 판매 채널] → 주문 발생 → OMS → 셀메이트 ← 판매자
              ↑                                              ↑
         셀메이트의 새 접점                         기존 접점 유지
         (구매자 데이터·행동 확보)
```

누리메이트를 통해 셀메이트는 **판매 채널까지 사업 범위를 확장**함으로써:

| 구분 | 기존 (OMS 한정) | 확장 후 (판매 채널 포함) |
|------|----------------|----------------------|
| 접점 대상 | 판매자만 | 판매자 + **구매자** |
| 데이터 범위 | 주문·정산 데이터 | 유입·탐색·구매 전 행동 데이터 포함 |
| CRM 가능 범위 | 판매자 CRM | 구매자 CRM (재구매·이탈 방지) 지원 |
| 수익 발생 경로 | OMS·정산 수수료 | + 판매 채널 수수료·PG 마진 |

**핵심 논리**: 구매자와의 접점을 확보하면 판매자가 구매자와 접촉하는 전 구간에서 CRM을 포함한 부가 서비스를 제공할 수 있고, 이는 셀메이트의 **단위 판매자당 매출 기여(ARPU)를 구조적으로 높입니다.**

### 왜 범용 솔루션이어야 하는가

커머스 판매 채널 사업의 매출은 두 가지 레버에서 발생합니다.

1. **거래 마진**: 판매자 GMV의 일정 비율을 수수료로 수취
2. **구매전환율 개선**: 구매 전환율이 높아질수록 GMV가 늘고 → 수수료 수익도 비례 증가

두 레버 모두 **규모의 경제**가 전제입니다. 판매자 수가 많을수록 총 GMV가 커지고, 플랫폼 고정비(인프라·PG 협상력·데이터 학습)는 분산됩니다.

이 때문에 누리메이트는 **스토어X처럼 소수의 특정 판매자를 타겟하는 버티컬 전략을 취하지 않습니다.** 스토어X는 깊은 버티컬 특화로 단가를 높이는 모델이지만, 판매 채널 사업은 판매자 수와 GMV 총량이 수익의 직접 변수이므로 범용 솔루션으로 매출 파이를 키우는 전략이 맞습니다.

```
스토어X 모델         누리메이트 모델
───────────          ──────────────
소수 판매자           다수 판매자
높은 단가             낮은 수수료율
버티컬 특화           범용 솔루션
깊은 커스터마이징       표준화된 확장

→ 규모 제한          → 규모의 경제 실현
```

---

## 시장 기회

### 한국

- 카페24 누적 스토어 **200만 개+** (2025년 기준), 전자상거래 플랫폼 시장 점유율 약 70%
- 한국 온라인 이커머스 시장: 2025년 **약 242조 원** (사상 최대), 2026년 300조 원 전망 (JP모건)
- 카페24·메이크샵의 복잡한 레거시 UI, AI 기능 부족 → 현대화 수요 존재
- 아임웹 누적 거래액 7조 원 돌파 (2025년 후반), 서비스 안정성 문제(2025년 3월 3회+ 장애) → 이탈 기회

**1차 타겟 재정의 (2026-03-25 전략 회의 확정)**

> 초기 공략 타겟을 "카페24 불만 판매자" 중심에서 **셀메이트 온오프라인 몰을 가진 디자이너 브랜드 버티컬**로 재정의했다.

| 구분 | 내용 |
|------|------|
| **1차 타겟** | 셀메이트 온오프라인 몰 보유 디자이너 브랜드 |
| **진입 논거** | 셀메이트 기존 고객사 → 아웃리치 비용 낮음, 온오프라인 연계 니즈 명확 |
| **시장 규모** | 한국 패션 브랜드 시장 2025년 **50.9조 원** (성장 중) |
| **공략 순서** | 매장 수 많은 브랜드 먼저 → 버티컬 장악 → 확장 |
| **2차 타겟** | 카페24 불만 판매자, 성장 중인 D2C 셀러 (1차 기반 확보 후) |

**전략 원칙: 버티컬로 좁게 시작 → 한 분야 확실히 장악 → 넓게 확장**

### 일본

- 도쿄 Shopify 스토어 18,142개, YoY **+16%** 성장 (2025년 Q4 기준)
- 일본 D2C 자사몰 시장: 2025년 **3조 엔 돌파**, 연 15~20% 성장 (전체 EC 성장률 5%의 3배)
- 일본 BtoC EC 시장 2024년 **26.1조 엔**, 2025년 28조 엔+ 전망 (경제산업성 공식 조사)
- Shopify는 일본 현지 결제(콘비니·PayPay·후불)를 네이티브 지원하지 않아 이중 수수료 구조 강요
- "마켓플레이스로 인지도 → 자사몰으로 전환" 2단계 공식이 일본 D2C 성공 패턴으로 정착

### 글로벌

- 동남아 D2C 이커머스, 마켓플레이스 의존 탈피 수요 지속 성장 중 (2025~2026년 가속화 추세)
- 한국 이커머스 솔루션의 아시아 확장성 검증 기회 (한류 브랜드 해외 직판 수요 증가)

---

## 경쟁 구도

```
                    글로벌 범용성
                         ↑
              Shopify ●  |
                         |           ● 누리메이트 (목표)
                         |           아시아 최적화 + 글로벌 확장
              카페24 ●   |
                         |
       BASE ● STORES ●   |
─────────────────────────────────────────→ 아시아 현지화 깊이
```

| | 카페24 | Shopify | 누리메이트 |
|---|---|---|---|
| 한국 결제 | ✅ 완전 지원 | ❌ 미지원 | ✅ 네이티브 |
| 일본 결제 (콘비니·PayPay) | △ 부분 지원 | ❌ 서드파티 필요 | ✅ 네이티브 |
| 글로벌 크로스보더 | △ 제한적 | ✅ 강점 | ⏸️ 보류 (국내 결제 우선) |
| AI 온보딩 | ❌ | △ | ✅ 30분 셋업 |
| 수수료 | 2.5~6% | 2.9%+월정액 | **0~2% 슬라이딩** |
| 통합 정산 대시보드 | ❌ | ❌ | ✅ |

---

> **[2026-03-25 결제 전략 확정]**
> - **한국 국내 결제**: 이니시스·토스페이먼츠로 처리 (우선 집중)
> - **일본 국내 결제**: GMO·SBPS를 셀메이트 일본 법인으로 직접 계약 처리 (우선 집중)
> - **크로스보더 결제**: 현재 보류 — 한국·일본 국내 결제 안정화 후 재검토
> - **Stripe Connect + 미국 법인 설립 구조**: 부정적 판단, 현재 추진 보류

## 핵심 차별점 (2026-03-25 확정)

카페24 대비 누리메이트만 보유한 3가지 구조적 차별점:

| 차별점 | 설명 | 카페24 |
|--------|------|--------|
| **온오프라인 연계** | 오프라인 POS 기반 재고 동기화·통합 정산. 온라인 자사몰과 오프라인 매장을 하나의 관리 화면으로 운영 | ❌ 미보유 |
| **헤드리스 완전 커스터마이징** | 프론트엔드 완전 독립 배포. 디자인 에이전시가 코드 제약 없이 쇼핑몰 구성 가능 | ❌ 제한적 |
| **포스(POS) 기반 기능** | 오프라인 매장 POS 데이터를 온라인 재고·주문·CRM과 실시간 연동 | ❌ 미보유 |

> 셀메이트 디자이너 브랜드 버티컬은 온오프라인 동시 운영 니즈가 높고, 카페24가 이 영역을 커버하지 못한다. 이 공백이 1차 진입 기회다.

---

## 핵심 기능 P0 (2026년 6월 런칭 필수)

| 기능 | 설명 |
|------|------|
| **AI 30분 온보딩** | 가입 → AI 안내 → 스토어 개설 → 첫 상품 등록까지 30분 이내 |
| **한국 결제 풀 지원** | 카카오페이·네이버페이·토스·가상계좌·카드 기본 탑재 |
| **일본 결제 패키지** | 신용카드·콘비니·PayPay 토글 1회로 즉시 활성화. 이중 수수료 없음 |
| **카페24 마이그레이션** | API 기반 상품·회원·주문 데이터 자동 이전. 개발자 없이 가능 |
| **멀티테넌시 도메인** | `{셀러}.nurymate.com` 자동 생성 + 커스텀 도메인 연결 |
| **운영자 어드민** | PG 심사 모니터링, 셀러 상태 관리, 정산 현황 조회 |
| **단위·현지화 자동 설정** | 판매 국가 선택 시 통화·세율·주소 형식·단위 자동 적용 |
| **헤드리스 API + AI 프론트빌더** | 헤드리스 커머스 API로 쇼핑몰 데이터 노출. AI 어시스턴트와 대화하듯 프론트엔드 화면(섹션·레이아웃·컴포넌트)을 코딩 없이 구성 가능 |
| **온오프라인 연계 (POS 연동)** | 오프라인 POS 데이터와 온라인 재고·주문 실시간 동기화. 셀메이트 디자이너 브랜드 버티컬 공략을 위한 핵심 기능 |
| **예약배송(프리오더) 시스템** | 브랜드의 생산 연동형 선주문 기능. 재고 없이 선판매 → 생산 확정 → 배송 처리 흐름 지원. 디자이너 브랜드·한정판 상품에 핵심 |

---

## 수익 구조

### 슬라이딩 수수료 모델 (2026-03-25 확정)

- 매출 규모에 따라 구간별 수수료 부과 (슬라이딩 구조)
- 성장할수록 플랫폼도 함께 수익 확대 → 판매자와 이해관계 일치
- 구체적 수수료 구간은 `pricing-model.md` 참조

### 유료 부가서비스 (2026-03-25 확정)

수수료 외 추가 수익원으로 유료 부가서비스 모델 병행:

| 부가서비스 | 설명 |
|-----------|------|
| **광고 대행사 연동** | 메타·구글·네이버 광고를 쇼핑몰 데이터와 연동해 자동화. 에이전시 파트너십 기반 수익 공유 |
| **프리미엄 기능 구독** | 고급 통계·AI 어시스턴트·인플루언서 매칭 |
| **마이그레이션 대행 서비스** | 카페24 이전 대행 유료 패키지 |
| **PG 파트너십 거래 마진** | 이니시스, 토스페이먼츠, 엑심베이, PayPal multiparty 계약 완료 |

### BEP 기준 (2026-03-25 확정)

> **월 거래액 20억 원, 수수료율 1% 기준** → 월 수익 2,000만 원

- 월 고정비 기준: 인건비 2명 × 500만 원 + AWS 인프라 약 87만 원 = **약 1,087만 원** (→ 상세: `bep-simulation.md`)
- BEP 달성 조건: **월 거래액 약 11억 원** (플랫폼 마진율 1% 단일 기준) 또는 부가서비스 수익 포함 시 하향 조정
- 플랫폼 마진 1.0% 시 BEP 판매자 약 55명 / 구독료(10만원) 병행 시 더 낮아짐. PG 마진(0.5%) 포함 시 실질 BEP 하향 조정됨
- 최소 **2억 원 운영 자금 선확보** 필요 (런칭~BEP 도달 약 4~5개월 런웨이) → [`pricing-model.md` 섹션 4 참조](./pricing-model.md)

---

## 타임라인

| 시점 | 마일스톤 |
|------|---------|
| **2026년 3월** | 기획 완료, 개발 착수, GMO-PG 협상 시작 |
| **2026년 6월** | 1차 런칭 (한국 베타) — 셀메이트 디자이너 브랜드 버티컬 + 카페24 이탈 판매자 타겟 |
| **2026년 Q3** | 한국 확산 + 일본 공식 출시 |
| **2026년 Q4** | 인플루언서 매칭, 고급 통계, AI 어시스턴트 |
| **2027년+** | 동남아(태국·인도네시아·베트남) 진입 |

---

## 팀 구성

| 역할 | 인원 |
|------|------|
| 웹프론트엔드 | 2명 |
| 백엔드 | 2명 |
| Flutter 앱 | 2명 |
| 디자이너 | 1명 |
| 주니어 PM | 1명 |
| 사업전략 | 1명 |
| **총** | **9명** |

AI 도구 활용으로 프론트·백·앱 경계를 넘나드는 유연한 업무 배분 운영.

---

## 리스크 Top 3

| 리스크 | 심각도 | 대응 방향 |
|--------|--------|---------|
| **PG 심사 지연** | 🔴 높음 | GMO-PG 협상 3월 착수 필수. 백업으로 Stripe Japan 병행 준비 |
| **Shopify의 일본 현지화 강화** | 🟡 중간 | 2025년 Mitsui 파트너십·PayPay 연동 시작. 선점 속도가 관건 — 6월 런칭 일정 사수 |
| **초기 브랜드 인지도 부재** | 🟡 중간 | 얼리어답터 10~20개 레퍼런스 스토어 우선 확보. 성공 사례 공개 마케팅 |

---

## 전체 문서 목록

### 전략

| 문서 | 설명 |
|------|------|
| [product-plan.md](./product-plan.md) | 핵심 제품 기획서 |
| [business-roadmap.md](./business-roadmap.md) | Phase별 사업 로드맵 |
| [pricing-model.md](./pricing-model.md) | 수익 구조 설계 |
| [strategic-analysis.md](./strategic-analysis.md) | SWOT·Lean Canvas·포지셔닝 분석 |
| [vertical-expansion.md](./vertical-expansion.md) | 버티컬 확장 전략 (패션→식품→코스메틱) |
| [organic-growth.md](./organic-growth.md) | SEO·AEO·GEO 자연 유입 전략 |
| [japan-gtm.md](./japan-gtm.md) | 일본 진출 GTM 전략 |
| [global-expansion-roadmap.md](./global-expansion-roadmap.md) | 글로벌 시장 진입 우선순위 |
| [early-customer-acquisition.md](./early-customer-acquisition.md) | 초기 고객 확보 전략 |
| [new-seller-acquisition.md](./new-seller-acquisition.md) | 신규 창업자 타겟 확보 전략 |
| [api-policy.md](./api-policy.md) | API 공개 및 써드파티 연동 정책 |

### 기능 기획 (Spec)

| 문서 | P | 설명 |
|------|---|------|
| [spec/seller-store-creation-ux.md](./spec/seller-store-creation-ux.md) | P0 | 셀러 스토어 생성 UX |
| [spec/domain-architecture.md](./spec/domain-architecture.md) | P0 | 멀티테넌시 도메인 구조 |
| [spec/jp-payment-native.md](./spec/jp-payment-native.md) | P0 | 일본 결제 네이티브 지원 |
| [spec/unit-localization.md](./spec/unit-localization.md) | P0 | 국가별 단위 현지화 |
| [spec/migration.md](./spec/migration.md) | P0 | 기존 몰 마이그레이션 |
| [spec/operator-admin.md](./spec/operator-admin.md) | P0 | 운영자 어드민 |
| [spec/module-definition.md](./spec/module-definition.md) | P0 | 모듈 기능 정의 |
| [spec/ai-storefront-builder.md](./spec/ai-storefront-builder.md) | P0 | 헤드리스 API + AI 프론트빌더 |
| [spec/unified-payment-dashboard.md](./spec/unified-payment-dashboard.md) | P1 | 통합 결제 대시보드 |
| [spec/first-sale-engine.md](./spec/first-sale-engine.md) | P1 | 첫 매출 견인 도구 |
| [spec/analytics-spec.md](./spec/analytics-spec.md) | P1 | 통계·분석 기능 |
| [spec/sns-marketing.md](./spec/sns-marketing.md) | P1 | SNS 마케팅 연동 |
| [spec/sns-review-collection.md](./spec/sns-review-collection.md) | P1 | SNS 리뷰 수집 |
| [spec/affiliate-tracking.md](./spec/affiliate-tracking.md) | P1 | 어필리에이트 트래킹 |
| [spec/country-preset.md](./spec/country-preset.md) | P1 | 국가별 설정 프리셋 |
| [spec/global-launch.md](./spec/global-launch.md) | P1 | 글로벌 진출 지원 기능 |
| [spec/influencer-matching.md](./spec/influencer-matching.md) | P2 | 인플루언서 매칭 |
| [spec/benchmark-report.md](./spec/benchmark-report.md) | P2 | 벤치마크 리포트 |
| [spec/ai-assistant.md](./spec/ai-assistant.md) | P2 | AI 운영 어시스턴트 |
| [spec/global-dashboard.md](./spec/global-dashboard.md) | P2 | 글로벌 통합 대시보드 |
| [spec/spec-priority.md](./spec/spec-priority.md) | — | 전체 Spec 우선순위 |

### 리서치

| 문서 | 설명 |
|------|------|
| [research/japan-korea-ecommerce.md](./research/japan-korea-ecommerce.md) | 일본·한국 이커머스 문화 비교 |
| [research/shopify-jp-payment-ux.md](./research/shopify-jp-payment-ux.md) | Shopify 일본 결제 불편 UX 조사 |
| [research/pg-stripe-support.md](./research/pg-stripe-support.md) | Stripe·PG 국내외 지원 조사 |
| [research/stripe-connect-countries.md](./research/stripe-connect-countries.md) | Stripe Connect 정산 가능 국가 |
| [research/paymentwall-analysis.md](./research/paymentwall-analysis.md) | Paymentwall 플랫폼 마진 구조 |
| [research/payoneer-analysis.md](./research/payoneer-analysis.md) | Payoneer 글로벌 PG 분석 |
| [research/local-pg-contracts.md](./research/local-pg-contracts.md) | 현지 PG사 직접 계약 난이도 |
| [research/korea-ecommerce-platforms.md](./research/korea-ecommerce-platforms.md) | 한국 이커머스 경쟁 지형 |
| [research/japan-ec-saas-comparison.md](./research/japan-ec-saas-comparison.md) | 일본 D2C EC SaaS 비교 |
| [research/logistics-strategy.md](./research/logistics-strategy.md) | 배송·3PL 전략 |
| [research/sns-review-legal.md](./research/sns-review-legal.md) | SNS 리뷰 수집 법적 검토 |
