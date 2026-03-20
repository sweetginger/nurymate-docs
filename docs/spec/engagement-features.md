# 재방문율 향상 기능 기획서

> 작성일: 2026-03-20 | 버전: v0.1 | 우선순위: P2 | 관련 태스크: [19-2]

---

## 목차

1. [개요](#1-개요)
2. [타사 현황 벤치마크](#2-타사-현황-벤치마크)
   - 2.1 출석체크
   - 2.2 룰렛·스핀 이벤트
   - 2.3 스탬프 카드
   - 2.4 포인트 적립
   - 2.5 미션·퀘스트
   - 2.6 뱃지 시스템
   - 2.7 등급·티어 시스템
3. [기능 정의 및 우선순위](#3-기능-정의-및-우선순위)
4. [헤드리스 이벤트 인터페이스 설계](#4-헤드리스-이벤트-인터페이스-설계)
5. [구현 우선순위 매트릭스](#5-구현-우선순위-매트릭스)
6. [로드맵 반영 시점 제안](#6-로드맵-반영-시점-제안)
7. [기술 고려사항](#7-기술-고려사항)
8. [참고 자료](#8-참고-자료)

---

## 1. 개요

### 1.1 배경

이커머스 플랫폼에서 신규 고객 유치 비용은 기존 고객 재방문 유도 비용의 **5~7배**에 달한다. 재방문율 향상 기능(게이미피케이션, 로열티 프로그램)은 엔드유저의 습관적 방문을 유도하고, 결과적으로 셀러의 GMV 성장과 누리메이트의 수수료 수익 증가로 이어진다.

누리메이트는 **헤드리스 커머스 구조**로 프론트엔드 구현이 다양하다. 셀러가 직접 개발한 스토어프론트이든, 누리메이트 기본 템플릿이든, 동일한 이벤트 인터페이스로 재방문율 향상 기능이 동작해야 한다.

### 1.2 목표

- 셀러가 **별도 서드파티 앱 없이** 기본 로열티 기능을 스토어에 적용 가능
- 헤드리스 구조에서도 **API 호출만으로** 모든 이벤트 처리 가능
- 구매 전환율(전환) 향상에 이어 **재방문율(리텐션)** 향상으로 플랫폼 가치 확장

### 1.3 핵심 지표 참고

| 기능 | 벤치마크 수치 | 출처 |
|------|-------------|------|
| 룰렛 팝업 전환율 | 평균 9.25% (일반 이메일 폼 3.53% 대비 ~3배) | Claspo |
| 로열티 프로그램 재구매율 | 164.4% 증가 | Yotpo |
| 룰렛 최적화 시 상위 1% | 62.5% 전환율 | Claspo |

---

## 2. 타사 현황 벤치마크

### 2.1 출석체크 (Daily Check-in)

매일 쇼핑몰 방문 시 적립금·쿠폰을 지급하여 재방문 습관 형성.

| 플랫폼 | 지원 방식 | 상세 |
|--------|-----------|------|
| **카페24** | ✅ 네이티브 (3가지 유형) | 스탬프형(달력에 도장), 로그인형(자동 인정), 댓글형(댓글 작성 시 인정). 디자인 커스터마이징 가능 |
| **아임웹** | ❌ 미지원 | 서드파티 앱 또는 자체 개발 필요 |
| **Shopify** | ❌ 앱 필요 | LoyaltyLion, Smile.io 등 앱에서 Daily Reward 구현 |
| **BigCommerce** | ❌ 앱 필요 | 서드파티 로열티 앱 연동 필요 |

**카페24 출석체크 상세**:
- 관리자 > 프로모션 > 출석 체크 이벤트에서 설정
- 출석 기간, 보상(적립금/쿠폰) 단위 설정
- 달력 이미지·스탬프 이미지 커스터마이징
- 연속 출석 보너스 설정 가능

### 2.2 룰렛·스핀 이벤트 (Lucky Wheel)

버튼 클릭 시 룰렛이 돌아가고 랜덤 보상(쿠폰·포인트·무료배송 등) 지급. 즉각적인 보상 기대감으로 참여율이 높다.

| 플랫폼 | 지원 방식 | 상세 |
|--------|-----------|------|
| **카페24** | ⚠️ 앱스토어 | 이벤트키키(eventkiki.com): 룰렛·출석·선물상자·프리퀀시 통합. API 1회 연동 후 자동 쿠폰·적립금 발급. 게임키키(gamekiki.com): 커스텀 디자인 패키지 49만원~ |
| **아임웹** | ❌ 자체 개발 필요 | 앱스토어에서 직접 연동 가능한 공식 룰렛 앱 없음 |
| **Shopify** | ⚠️ 앱스토어 | Spin Wheel+Gamification+Games 등 다수 앱. OptiMonk, Claspo 등 팝업 툴에서 드래그앤드롭으로 구현 가능 |
| **SaaS 팝업 툴** | ⚠️ 외부 서비스 | Claspo, OptiMonk, PopupSmart — 노코드 스핀 휠 빌더. 이메일 수집 + 쿠폰 발급 통합 |

**성과 사례**: Jar(디지털 골드 저축 앱)는 매일 스핀 휠로 보너스 지급, 일일 방문 루틴 형성.

### 2.3 스탬프 카드 (Frequency Card)

구매 횟수·특정 행동마다 스탬프 적립, 일정 개수 도달 시 보상 지급.

| 플랫폼 | 지원 방식 | 상세 |
|--------|-----------|------|
| **카페24** | ⚠️ 앱스토어 | 이벤트키키의 프리퀀시 스티커 기능으로 구현 가능 |
| **Smile.io** | ✅ 네이티브 | 디지털 스탬프 카드를 포인트 시스템과 병행 운영. 무료 플랜부터 지원 |
| **PassKit** | ✅ 전문 서비스 | Apple/Google Wallet 연동 디지털 로열티 카드 SaaS |

### 2.4 포인트 적립 (Points Accumulation)

구매·리뷰·가입·추천 등 다양한 행동에 포인트를 부여하고, 할인·보상으로 교환.

| 플랫폼 | 지원 방식 | 보상 이벤트 | 가격 |
|--------|-----------|-------------|------|
| **카페24** | ✅ 네이티브 | 구매, 이벤트 참여. 회원 등급별 차등 적립률 | 무료 |
| **아임웹** | ✅ 네이티브 | 구매 기본 지원. Pro 버전 이상 등급 연동 | Pro 플랜 이상 |
| **Smile.io** | ✅ 강력 | 구매·가입·생일·리뷰·소셜 액션. 월 500주문까지 무료 | $0~$999/월 |
| **LoyaltyLion** | ✅ 강력 | 구매·계정 생성·생일·리뷰·소셜·기념일. API는 $729/월 이상 | $0~$729+/월 |
| **Yotpo Loyalty** | ✅ 강력 | 20+ 캠페인 타입. 재구매율 164.4% 향상 ROI 보고 | $0~$199+/월 |

### 2.5 미션·퀘스트 (Mission / Quest)

'첫 구매', '리뷰 3개 작성', '친구 추천' 등 목표 완료 시 보상 지급. 단순 포인트보다 목적의식을 부여하여 참여율 향상.

**운영 사례 (CJ더마켓 'THE PLAY')**:
- "Fai와 대화하고 매일 10원 받기"
- "쇼핑 라이브 보기"
- "럭키박스 참여"
→ 일일 미션으로 충성 고객 습관 형성

**기술 특성**: 완료 조건이 복잡할수록 API 기반 구현 필수. 이벤트 발생 → 미션 진행도 체크 → 완료 시 보상 트리거 흐름.

### 2.6 뱃지 시스템 (Badge System)

특정 행동 달성 시 시각적 뱃지 부여. 경제적 가치보다 상징적 가치로 성취감·소속감 제공.

| 플랫폼 | 지원 방식 |
|--------|-----------|
| **LoyaltyLion** | 신규 등급 진입 시 Tier Badge 지급 (요청 시 활성화) |
| **Yotpo** | 마일스톤 달성 뱃지 포함 20+ 캠페인 타입 |
| **Annex Cloud** | 포인트·티어·보상 추적 행동에 뱃지 연동 |

### 2.7 등급·티어 시스템 (Tier / Grade System)

구매 금액·횟수·활동 점수에 따라 일반→실버→골드→VIP→VVIP 등급 부여, 등급별 혜택 차등 제공. 장기 관계 형성에 가장 효과적인 리텐션 구조.

| 플랫폼 | 지원 방식 | 웹훅 이벤트 |
|--------|-----------|------------|
| **카페24** | ✅ 네이티브 | 회원 등급 관리 메뉴. 등급별 차등 적립률 |
| **아임웹** | ✅ 네이티브 (Pro 이상) | 총구매·최근구매 기준 자동 승급 |
| **LoyaltyLion** | ✅ API | 최대 4단계 VIP 티어. `tier_upgraded`/`tier_downgraded` 웹훅 |
| **Smile.io** | ✅ 네이티브 | VIP 티어 + Nudge 알림으로 등급 달성 독려 |
| **Yotpo** | ✅ 네이티브 | 등급별 배지·혜택. 등급 접근 마일스톤 웹훅 |
| **Open Loyalty** | ✅ API | `CustomerLevelChanged` 이벤트 발행 |

---

## 3. 기능 정의 및 우선순위

### 3.1 기능 목록 (우선순위 순)

| 기능 | 재방문 효과 | 구현 난이도 | 비용 | 우선순위 |
|------|-------------|-------------|------|----------|
| 포인트 적립 | 높음 | 낮음~중간 | 중간 | **P1** |
| 등급·티어 시스템 | 매우 높음 (장기) | 중간 | 중간 | **P1** |
| 출석체크 | 높음 | 낮음 | 낮음 | **P2** |
| 미션·퀘스트 | 높음 | 중간~높음 | 중간 | **P2** |
| 룰렛·스핀 이벤트 | 중간 (단기 급등) | 낮음 (앱 이용 시) | 낮음 | **P2** |
| 스탬프 카드 | 중간 | 낮음~중간 | 낮음 | **P3** |
| 뱃지 시스템 | 중간 (보조) | 중간 | 낮음 | **P3** |

### 3.2 기능별 상세 정의

#### 포인트 적립

| 항목 | 내용 |
|------|------|
| 기본 적립 | 구매 금액의 N% 자동 적립 (셀러 설정) |
| 이벤트 적립 | 회원가입 웰컴 포인트, 생일 보너스, 첫 구매 보너스 |
| 리뷰 보상 | 리뷰 작성 시 포인트 지급 (텍스트/포토 차등) |
| 추천인 보상 | 친구 추천 가입·첫 구매 완료 시 추천인·피추천인 동시 지급 |
| 포인트 사용 | 결제 시 포인트 금액 차감 (셀러 설정: 최대 사용 비율 제한) |
| 만료 정책 | 마지막 활동으로부터 N개월 미사용 시 소멸 (셀러 설정) |

#### 등급·티어 시스템

| 항목 | 내용 |
|------|------|
| 등급 기준 | 기간 내 총 구매 금액 또는 구매 횟수 (셀러 선택) |
| 등급 수 | 최대 5단계 (BASIC / SILVER / GOLD / VIP / VVIP) |
| 등급별 혜택 | 적립률 차등, 무료 배송 적용, 전용 쿠폰, 조기 접근권 |
| 등급 산정 주기 | 월별 / 분기별 / 연별 (셀러 설정) |
| 등급 알림 | 등급 상승 축하 메시지, "N포인트 더 적립 시 VIP" Nudge 알림 |
| 등급 하락 | 기간 내 활동 미달 시 자동 하락 + 재활성화 캠페인 트리거 |

#### 출석체크

| 항목 | 내용 |
|------|------|
| 인정 기준 | 로그인 또는 스토어 URL 방문 (셀러 선택) |
| 보상 단위 | 포인트 또는 쿠폰 (셀러 설정) |
| 연속 보너스 | N일 연속 출석 시 추가 보너스 |
| 출석 UI | 달력형 스탬프 위젯 (API 응답 기반, 프론트가 렌더링) |

#### 미션·퀘스트

| 항목 | 내용 |
|------|------|
| 미션 타입 | 단발성 (첫 구매 완료), 반복형 (월 N회 구매), 기간형 (이벤트 기간 내) |
| 완료 조건 | 구매·리뷰·추천·출석 등 이벤트 기반 자동 체크 |
| 보상 | 포인트·쿠폰·배지 중 선택 |
| 진행 현황 | GET /api/v1/loyalty/missions/{customer_id}로 조회 |

---

## 4. 헤드리스 이벤트 인터페이스 설계

### 4.1 설계 원칙

누리메이트는 헤드리스 커머스 구조로, 프론트엔드 구현(Next.js, React Native, 외부 스토어프론트)에 무관하게 동일한 API 엔드포인트 호출만으로 로열티 기능이 동작해야 한다.

```
[Frontend A (Next.js)]  ─┐
[Frontend B (Mobile)]   ─┼─→  POST /api/v1/loyalty/events  →  [Loyalty Engine]
[Frontend C (Custom)]   ─┘                                         │
                                                                    ↓
                                                          [Webhook Dispatch]
                                                                    │
                                              ┌─────────────────────┼──────────────────────┐
                                              ↓                     ↓                      ↓
                                        CRM/이메일           Push 알림 서비스        프론트 SSE
```

### 4.2 이벤트 수신 API

#### POST /api/v1/loyalty/events

모든 프론트엔드가 호출하는 단일 이벤트 엔드포인트.

**Request**:
```json
{
  "event_type": "customer.purchase_completed",
  "customer_id": "cust_abc123",
  "store_id": "store_xyz",
  "idempotency_key": "ord_789_loyalty",
  "occurred_at": "2026-03-20T10:30:00Z",
  "metadata": {
    "order_id": "ord_789",
    "order_amount": 45000,
    "items": [{"product_id": "prod_001", "quantity": 2}]
  }
}
```

**Response**:
```json
{
  "status": "accepted",
  "event_id": "evt_xxx",
  "processing": "async"
}
```

- 수신 즉시 `202 Accepted` 반환 (비동기 처리)
- `idempotency_key`로 중복 이벤트 방지 (새로고침·재시도 시 중복 지급 차단)

#### 이벤트 타입 목록

| 이벤트 타입 | 설명 | 포인트 지급 | 미션 체크 |
|-------------|------|------------|----------|
| `customer.purchase_completed` | 주문 완료 | ✅ 주문 금액 기반 | ✅ |
| `customer.daily_login` | 일별 로그인/방문 | ✅ 출석체크 | ✅ |
| `customer.review_submitted` | 리뷰 작성 | ✅ | ✅ |
| `customer.referral_converted` | 추천인 가입 완료 | ✅ 추천인·피추천인 동시 | ✅ |
| `customer.account_created` | 회원가입 | ✅ 웰컴 포인트 | ✅ |
| `customer.birthday` | 생일 | ✅ | - |
| `customer.social_follow` | SNS 팔로우 | ✅ | ✅ |
| `customer.mission_completed` | 미션 완료 확인 | ✅ | - |
| `customer.spin_wheel_played` | 룰렛 참여 | 결과에 따라 | ✅ |
| `customer.stamp_collected` | 스탬프 적립 | 조건부 | ✅ |

### 4.3 잔액 조회 API

#### GET /api/v1/loyalty/balance/{customer_id}

```json
{
  "customer_id": "cust_abc123",
  "available_points": 3200,
  "pending_points": 450,
  "lifetime_points": 12800,
  "current_tier": "GOLD",
  "next_tier": "VIP",
  "points_to_next_tier": 1800,
  "tier_expires_at": "2026-12-31"
}
```

#### GET /api/v1/loyalty/missions/{customer_id}

```json
{
  "missions": [
    {
      "mission_id": "mission_001",
      "title": "첫 구매 완료하기",
      "description": "첫 번째 주문을 완료하세요",
      "type": "one_time",
      "progress": 0,
      "target": 1,
      "completed": false,
      "reward": {"type": "points", "amount": 1000},
      "expires_at": null
    }
  ]
}
```

### 4.4 웹훅 발행 이벤트 (로열티 엔진 → 외부)

| 웹훅 이벤트 | 트리거 조건 | 주요 활용 |
|-------------|-------------|-----------|
| `loyalty.points_earned` | 포인트 적립 완료 | CRM 고객 데이터 갱신, 앱 푸시 |
| `loyalty.points_redeemed` | 포인트 사용 | 잔액 갱신 알림 |
| `loyalty.tier_upgraded` | 등급 상승 | 축하 이메일, 뱃지 지급 |
| `loyalty.tier_downgraded` | 등급 하락 | 재활성화 캠페인 트리거 |
| `loyalty.tier_approaching` | 등급 달성 N포인트 이내 | "N포인트 더 적립 시 VIP" Nudge 알림 |
| `loyalty.reward_redeemed` | 쿠폰·혜택 사용 | 사용 확인 알림 |
| `loyalty.badge_awarded` | 뱃지 획득 | 알림 + 프론트 UI 업데이트 |
| `loyalty.mission_completed` | 미션 완료 | 보상 지급 트리거 |
| `loyalty.referral_converted` | 추천 성공 | 추천인·피추천인 동시 보상 |

**웹훅 페이로드 표준**:
```json
{
  "id": "wh_evt_xxx",
  "store_id": "store_xyz",
  "created_at": "2026-03-20T10:30:05Z",
  "type": "loyalty.tier_upgraded",
  "data": {
    "customer_id": "cust_abc123",
    "previous_tier": "SILVER",
    "new_tier": "GOLD",
    "triggering_event_id": "evt_xxx"
  }
}
```

**재시도 정책**: 외부 시스템 장애 시 지수 백오프(1s → 2s → 4s → 8s → 16s)로 최대 5회 재시도.

### 4.5 프론트엔드 연동 방식

**출석체크 UI 구현 예시 (Next.js)**:
```typescript
// 출석체크 이벤트 발행
async function recordDailyVisit(customerId: string) {
  await fetch('/api/v1/loyalty/events', {
    method: 'POST',
    body: JSON.stringify({
      event_type: 'customer.daily_login',
      customer_id: customerId,
      idempotency_key: `daily_${customerId}_${new Date().toISOString().split('T')[0]}`,
      occurred_at: new Date().toISOString(),
    }),
  });
}

// 잔액·등급 조회
async function getLoyaltyStatus(customerId: string) {
  const res = await fetch(`/api/v1/loyalty/balance/${customerId}`);
  return res.json(); // { available_points, current_tier, points_to_next_tier, ... }
}
```

**룰렛 결과 처리 흐름**:
```
프론트: 룰렛 UI 애니메이션 실행 (클라이언트 사이드)
       ↓
프론트: POST /api/v1/loyalty/events { event_type: "customer.spin_wheel_played" }
       ↓
서버: 보상 결정 (쿠폰/포인트/꽝) → 결과 응답
       ↓
프론트: 결과 오버레이 표시 + 포인트 잔액 갱신
```

---

## 5. 구현 우선순위 매트릭스

| 기능 | 우선순위 | 기대 효과 | 구현 난이도 | 로드맵 Phase |
|------|----------|-----------|-------------|-------------|
| 포인트 적립 (구매 기반) | **P1** | 재구매율 직접 연결 | 중간 | Phase 2 |
| 등급 시스템 (2단계: 일반/VIP) | **P1** | 장기 로열티 형성 | 중간 | Phase 2 |
| 이벤트 인터페이스 API | **P1** | 헤드리스 호환성 필수 | 중간 | Phase 2 |
| 웹훅 발행 인프라 | **P1** | 외부 CRM·알림 연동 | 중간 | Phase 2 |
| 출석체크 | **P2** | 일일 방문 루틴 형성 | 낮음 | Phase 3 |
| 미션·퀘스트 (단순형) | **P2** | 특정 행동 유도 | 중간 | Phase 3 |
| 등급 시스템 (최대 5단계) | **P2** | 고급 세분화 | 중간 | Phase 3 |
| 룰렛·스핀 이벤트 | **P2** | 단기 이벤트 효과 | 낮음 | Phase 3 |
| 뱃지 시스템 | **P3** | 성취감 보조 | 중간 | Phase 4 |
| 스탬프 카드 | **P3** | 특정 상품군 유효 | 낮음~중간 | Phase 4 |
| 미션 고급형 (복합 조건) | **P3** | 대형 이벤트용 | 높음 | Phase 4 |

---

## 6. 로드맵 반영 시점 제안

### Phase 2 (MVP 이후, 2026 Q3 목표)

**포인트 적립 + 등급 시스템 기본 + 이벤트 API**

- 포인트 적립: 구매 기반 기본 적립 + 관리자 설정 UI
- 등급: 일반/VIP 2단계 (총 구매금액 기준)
- 이벤트 수신 API: `purchase_completed`, `account_created`, `review_submitted`
- 웹훅 발행: `points_earned`, `tier_upgraded`

**선택 이유**: GMV 성장 후 수수료 수익과 직결되는 로열티 기능. 포인트·등급은 카페24·아임웹 전환 셀러가 기대하는 기본 기능. 이벤트 API는 이후 모든 기능의 인프라.

### Phase 3 (2026 Q4 목표)

**출석체크 + 미션(단순) + 등급 고도화 + 룰렛**

- 출석체크: 로그인형 기본 + 포인트 지급
- 미션: 단발성 미션 5종 (가입, 첫 구매, 첫 리뷰, 친구 추천, SNS 팔로우)
- 등급: 5단계로 확장 + 등급 임박 Nudge 알림
- 룰렛: 셀러 설정 UI + 프론트 위젯 (기본 디자인 제공)

### Phase 4 (2027 Q1 이후)

**뱃지 + 스탬프 + 미션 고급형**

- 뱃지: 등급 진입 배지 + 커스텀 뱃지 셀러 설정
- 스탬프 카드: 특정 상품 구매 횟수 기반
- 미션 고급형: 복합 조건, 기간형, 팀 미션

---

## 7. 기술 고려사항

### 7.1 로열티 엔진 아키텍처

```
[Event API Gateway]
       ↓
[Event Queue (Redis / SQS)]
       ↓
[Loyalty Engine (Async Workers)]
    │   ├── Point Calculator
    │   ├── Tier Evaluator
    │   ├── Mission Tracker
    │   └── Badge Evaluator
       ↓
[Write DB] → [Webhook Dispatcher]
```

**멱등성 보장**: `idempotency_key` + `(event_type, customer_id, key)` 유니크 인덱스로 중복 처리 방지.

### 7.2 핵심 데이터 모델

```
LoyaltyEvent { id, event_type, customer_id, store_id, metadata, idempotency_key, occurred_at, processed_at }
PointBalance { customer_id, store_id, available_points, pending_points, lifetime_points }
CustomerTier { customer_id, store_id, current_tier, tier_points, period_start, period_end }
Mission { id, store_id, title, type, conditions[], reward }
MissionProgress { mission_id, customer_id, progress, completed_at }
WebhookSubscription { store_id, url, events[], secret, active }
```

### 7.3 포인트 정합성

- 포인트 지급·차감은 트랜잭션으로 처리
- 주문 취소 시 적립 포인트 자동 회수 (취소 이벤트 연동)
- `pending_points`: 구매 후 반품 기간 동안 보류, 기간 종료 시 `available_points`로 이동

### 7.4 헤드리스 호환 설계

- 모든 로열티 상태는 `GET /api/v1/loyalty/balance/{customer_id}`로 조회 가능
- 프론트엔드가 직접 렌더링하는 위젯(출석체크 달력, 등급 배지, 포인트 잔액)은 API 응답 기반
- 기본 제공 위젯: Web Component 형태로 `<nurymate-loyalty-widget>` 임베드 지원 (선택)

---

## 8. 참고 자료

- 카페24 헬프센터: 출석 체크 이벤트, 적립금 설정
- 아임웹 FAQ: 쇼핑등급 설정하기
- 카페24 앱스토어: 이벤트키키, 게임키키
- LoyaltyLion Developer Portal: Headless API, Loyalty Tiers API
- Yotpo Loyalty: Webhook Events, All Webhook Events
- Smile.io Developer Docs: Event Notifications
- Voucherify: Introduction to Webhooks, Customer Rewarded Loyalty Points
- Open Loyalty: Loyalty Program API
- Claspo: Spin-the-Wheel Popup Guide (전환율 9.25% 데이터)
- Yotpo Blog: Yotpo vs LoyaltyLion vs Smile.io 비교 (재구매율 164.4% 데이터)
- 이벤트키키 공식 사이트 (eventkiki.com)
