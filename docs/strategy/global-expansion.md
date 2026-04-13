# 셀메이트CM 글로벌 확장 전략 (보류 문서 모음)

> 작성일: 2026-04-06
> 상태: ⏸ 보류 — 한국·일본 진입 안정화 후 재검토 (2027년+ 목표)

---

## 배경

2026-03-25 전략 회의에서 셀메이트CM의 우선 집중 시장을 **한국 + 일본**으로 확정했다.

- **한국 국내 결제**: 이니시스·토스페이먼츠 우선 집중
- **일본 국내 결제**: GMO·SBPS를 셀메이트 일본 법인으로 직접 계약 처리
- **크로스보더 결제**: 보류 — 한국·일본 국내 결제 안정화 후 재검토
- **Stripe Connect + 미국 법인 설립 구조**: 부정적 판단, 현재 보류

이 문서는 글로벌 확장 단계에서 참조할 연구 및 전략 문서들을 인덱싱한다.

---

## 1. 글로벌 시장 진입 우선순위 (2027년+ 대상)

2차 타겟 시장 후보:

| 시장 | 진입 근거 | 주요 장벽 | 우선순위 |
|------|---------|---------|---------|
| 동남아 (태국·인도네시아·베트남) | 한류 브랜드 직판 수요 급증, 마켓플레이스 의존 탈피 추세 | 현지 PG 계약·법인 설립 복잡성 | ① |
| 대만 | 중화권 입문 시장, 한국 이커머스 친화적 | 번체자 UX 대응 | ② |
| 미국 (Stripe Connect 구조) | 글로벌 크로스보더 기반 확장 | 미국 법인 설립, 세금·법률 복잡성 | ③ |

---

## 2. 참조 문서 목록

### 2.1 크로스보더 결제 관련 (현재 보류)

| 문서 | 내용 |
|------|------|
| [research/stripe-connect-countries.md](./research/stripe-connect-countries.md) | Stripe Connect 정산 가능 국가 조사 |
| [research/pg-stripe-support.md](./research/pg-stripe-support.md) | Stripe·PG 국내외 지원 범위 조사 |
| [research/paymentwall-analysis.md](./research/paymentwall-analysis.md) | Paymentwall 글로벌 결제 마진 구조 |
| [research/payoneer-analysis.md](./research/payoneer-analysis.md) | Payoneer 글로벌 PG 대안 분석 |

### 2.2 글로벌 시장 진입 전략

| 문서 | 내용 |
|------|------|
| [global-expansion-roadmap.md](./global-expansion-roadmap.md) | 글로벌 시장 진입 우선순위 및 단계 계획 |
| [research/global-market-overview.md](./research/global-market-overview.md) | 글로벌 이커머스 시장 개요 |
| [research/global-ux-design.md](./research/global-ux-design.md) | 글로벌 이커머스 UX 디자인 연구 |

### 2.3 글로벌 기능 스펙 (Phase 3+ 대상)

| 문서 | 우선순위 | 내용 |
|------|---------|------|
| [spec/global-launch.md](./spec/global-launch.md) | P2 (크로스보더 활성화 시) | 글로벌 진출 지원 기능 (이미지 번역·다국어 확장) |
| [spec/global-dashboard.md](./spec/global-dashboard.md) | P3 | 글로벌 통합 대시보드 (다국가 진출 이후) |

---

## 3. 재검토 조건

다음 중 하나 충족 시 이 문서의 내용을 현행화하여 실행 계획으로 전환:

1. 한국 유료 머천트 200명 달성 (2026 Q4 목표)
2. 일본 유료 머천트 100명 달성 (2026 Q4 목표)
3. 월 GMV 20억 원 초과 (BEP 달성)
4. 동남아 브랜드로부터 인바운드 문의 10건 이상 수신

---

## 4. 관련 현행 문서

글로벌 확장과 관련이 있지만 한국·일본 진입 전략에도 활용되는 문서:

| 문서 | 글로벌 연관성 |
|------|------------|
| [japan-gtm.md](./japan-gtm.md) | 아시아 현지화 모델의 기준 사례 |
| [research/logistics-strategy.md](./research/logistics-strategy.md) | 국제 배송·3PL 전략 (일본 배송 + 글로벌 공통) |
| [research/local-pg-contracts.md](./research/local-pg-contracts.md) | 현지 PG 직접 계약 모델 (일본 적용 중, 글로벌 확장 시 재활용) |
