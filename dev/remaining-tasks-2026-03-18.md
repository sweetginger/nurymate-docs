# 누리메이트 미완료 태스크 잔여 작업 계획

> 작성일: 2026-03-18 | 목적: 컨텍스트 압축 후 재개 기준 문서

---

## 완료된 작업 (✅)

| 태스크 | 산출물 | 상태 |
|--------|--------|------|
| [15-1] 경쟁사 UX 업데이트 조사 | `research/competitor-ux-updates.md` | ✅ 완료 |
| [15-2] SSL 자동 발급 조건 검증 | `spec/seller-store-creation-ux.md` 2.5 섹션 추가 | ✅ 완료 |
| [15-3] 인스타그램 연동 분석 | `spec/sns-marketing.md` 섹션 10 추가 | ✅ 완료 |
| [15-5] 무통장입금→가상계좌 전환 | `spec/payment-bank-transfer.md` 신규 | ✅ 완료 |
| [15-6] 자동 입금확인 구현 방법 | `spec/payment-bank-transfer.md` 섹션 3 | ✅ 완료 |
| [16-1] Payoneer 플랫폼 마진 | `research/payoneer-analysis.md` 섹션 5 추가 | ⏳ 재실행 중 |
| [16-2] 글로벌 UX 차이점 조사 | `research/global-ux-design.md` 신규 | ⏳ 재실행 중 |
| [16-3] S4-02 사이즈 변환 수정 | `user-scenarios.md` | ✅ 완료 |
| [16-4] S4-03 HS코드 속성 보완 | `user-scenarios.md` | ✅ 완료 |
| [16-5] S4-05 어필리에이트 수정 | `user-scenarios.md` | ✅ 완료 |
| [16-6] S4-06 CSV AI 매핑 재작성 | `user-scenarios.md` | ✅ 완료 |
| [16-7] S5-04 마지막 문장 수정 | `user-scenarios.md` | ✅ 완료 |
| [16-8] 신규 시나리오 5개 세트 | `user-scenarios.md` S6~S10 (30→47개) | ✅ 완료 |
| [17-1] Shopify AI 어시스턴트 조사 | `research/shopify-ai-assistant.md` 신규 | ✅ 완료 |
| [17-2] ai-chat-setting 연동 흐름 | `spec/ai-chat-setting.md` 섹션 8 추가 | ✅ 완료 |
| [17-3] 한국 이커머스 요금 추가 | `research/korea-ecommerce-platforms.md` 섹션 추가 | ✅ 완료 |
| [17-4] first-sale-engine 재원 | `spec/first-sale-engine.md` 도구3 섹션 추가 | ✅ 완료 |
| [17-6] 결제 수수료 원가 표 | `research/payment-fee-structure.md` 신규 + `spec/jp-payment-native.md` 7.2 수정 | ✅ 완료 |
| [17-7] 국가 감지 방식 수정 | `spec/seller-store-creation-ux.md` 2.2 수정 | ✅ 완료 |
| [17-8] AI 생성 단일 흐름 통합 | `spec/seller-store-creation-ux.md` 3.4 수정 | ✅ 완료 |
| [17-9] Shopify Markets 구조 조사 | `research/shopify-markets-localization.md` 신규 | ✅ 완료 |
| [17-11] 발송 프로필 필요성 검증 | `research/shipping-profile-validation.md` 신규 | ✅ 완료 |
| [17-12] YouTube Shopping 파트너 | `research/youtube-shopping-partner.md` 신규 | ⏳ 재실행 중 |
| [17-13] SNS 리뷰 X·틱톡·스레드 | `spec/sns-review-collection.md` 섹션 7 추가 | ✅ 완료 |
| [17-10] 전환율 향상 기능 기획서 | `spec/conversion-rate-features.md` 신규 | ⏳ 재실행 중 |

---

## 잔여 작업 (재실행 또는 미착수)

### 즉시 처리 필요 (재실행 중 — 완료 알림 대기)

| # | 태스크 | 산출물 | 에이전트 ID |
|---|--------|--------|-----------|
| 1 | [16-1] Payoneer 마진 구조 | `research/payoneer-analysis.md` 수정 | a4b6f19eb8d7b6446 |
| 2 | [16-2] 글로벌 UX 디자인 | `research/global-ux-design.md` 신규 | aec89bb5e9e803515 |
| 3 | [17-12] YouTube Shopping | `research/youtube-shopping-partner.md` 신규 | a6284991ab26eed11 |
| 4 | [17-10] 전환율 향상 기능 | `spec/conversion-rate-features.md` 신규 | a7fdede9be67ff94e |

### Wave 5 — 위 4개 완료 후 착수

| # | 태스크 | 산출물 | 의존성 |
|---|--------|--------|--------|
| 5 | [17-5] Phase별 작업 목록 | `strategy/phase-task-list.md` 신규 | 위 4개 완료 후 |

### 최종 — tasks.md ✅ 마킹

| # | 작업 | 대상 |
|---|------|------|
| 6 | 완료 태스크 ✅ 표시 | `products/nurymate/tasks.md` 섹션 15~17 |

### Wave 6 — 옵셔널

| # | 태스크 | 산출물 | 우선순위 |
|---|--------|--------|---------|
| 7 | [15-4] 입점형 쇼핑몰 기획 | `spec/marketplace-integration.md` | 낮음 (옵셔널) |

---

## 재개 시 체크포인트

완료 알림이 오면 이 파일의 ⏳ 항목을 확인하고 아래 순서로 처리:

1. 4개 에이전트 완료 확인 → 파일 존재 검증
2. [17-5] phase-task-list.md 실행
3. tasks.md 섹션 15~17에 ✅ 마킹
4. (옵셔널) [15-4] 실행

---

## 검증 방법

```bash
# 완료 파일 존재 확인
ls products/nurymate/strategy/research/global-ux-design.md
ls products/nurymate/strategy/research/youtube-shopping-partner.md
ls products/nurymate/strategy/spec/conversion-rate-features.md

# payoneer 수정 확인 (섹션 5 추가 여부)
grep "플랫폼 마진 수취" products/nurymate/strategy/research/payoneer-analysis.md
```
