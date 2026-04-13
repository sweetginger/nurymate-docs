# 셀메이트CM 통계 고도화 기능 정의서

> 작성일: 2026-03-06
> 버전: v0.1 (초안)
> 관련 문서: `strategy/product-plan.md`, `strategy/research/cafe24-analytics.md`

---

## 목차

1. [개요](#1-개요)
2. [통계 데이터 수집 범위](#2-통계-데이터-수집-범위)
3. [대시보드 구성](#3-대시보드-구성)
4. [리포트 카테고리별 지표 정의](#4-리포트-카테고리별-지표-정의)
5. [GA4 통합 방식](#5-ga4-통합-방식)
6. [기술 요건](#6-기술-요건)
7. [구현 우선순위](#7-구현-우선순위)
8. [경쟁 우위 포인트](#8-경쟁-우위-포인트)

---

## 1. 개요

### 1.1 목표

셀메이트CM의 통계 고도화는 단순 매출 확인 수준의 통계 기능을 넘어, 머천트가 **데이터 기반 의사결정**을 직접 수행할 수 있는 분석 환경을 제공하는 것을 목표로 한다.

핵심 지향점은 다음 세 가지다:

1. **Shopify Analytics 수준 이상의 내장 분석 기능** — 서드파티 BI 도구 없이 핵심 인사이트 도출 가능
2. **GA4 연동 완결성** — 간편결제 데이터 누락 없는 완전한 퍼널 추적 (카페24의 핵심 약점 해소)
3. **AI 서머리 자동화** — 데이터를 읽지 못하는 운영자도 매일 아침 인사이트를 받는 구조

**해결할 핵심 문제 (카페24 이탈 이유 기반):**

| 문제 | 카페24 현황 | 셀메이트CM 목표 |
|------|-----------|--------------|
| 실시간 데이터 없음 | 1시간 주기 배치 | 실시간 + 5분 배치 |
| 간편결제 데이터 누락 | GA4 연동 시 빈번 누락 | 자체 수집으로 100% 추적 |
| 통계 수치 불일치 | GA4 vs 카페24 vs 광고 플랫폼 간 불일치 | 단일 Source of Truth |
| 코호트 분석 없음 | 미제공 | Phase 2에서 제공 |
| 퍼널 분석 제한 | 제한적 | Phase 1 MVP에 포함 |

### 1.2 베이스라인 분석 (카페24 현황)

카페24가 기본 제공하는 통계 기능 전수:

**매출 분석**
- 일/주/월별 매출 현황
- 결제 수단별 매출 (카드, 무통장, 간편결제)
- 멀티쇼핑몰별 매출 집계
- 총 매출 집계표 (판매 이익 포함)

**상품 분석**
- 판매 상품 순위, 판매 분류 순위
- 취소/반품 상품 순위
- 공급사/브랜드별 판매 순위
- 장바구니 담기 상품, 관심 상품 순위
- 장바구니 상세 내역

**고객 분석**
- 요일별/시간별 고객 유입 분석
- 회원 등급별 고객 분석
- 배송 지역별 고객 분포
- 적립금/예치금 통계

**접속 통계 (트래픽)**
- 유입 경로별 분석 (검색엔진, 직접 유입 등)
- 페이지뷰, 방문자 수
- 마케팅 채널별 효과 분석

**카페24의 핵심 한계 (셀메이트CM가 반드시 해결해야 하는 항목):**
- 집계 주기 1시간 (실시간 불가)
- 코호트 분석 없음
- A/B 테스트 없음
- 퍼널 단계별 이탈율 분석 제한적
- 간편결제(네이버페이, 카카오페이 등) GA4 연동 시 데이터 누락
- GA4 수치 vs 카페24 수치 불일치 (어떤 수치가 맞는지 모르는 상태)
- 커스텀 리포트 없음

### 1.3 벤치마크 대상 (Shopify Analytics 수준 이상)

**Shopify Analytics 제공 범위 (벤치마크 기준):**

Shopify는 구독 플랜에 따라 60~80개 이상의 사전 정의 리포트를 제공하며, 리포트 카테고리는 다음과 같다:

| 카테고리 | 주요 리포트 |
|---------|-----------|
| Acquisition (유입) | Sessions over time, Sessions by referrer, Sessions by location |
| Behavior (행동) | Conversion rate breakdown, Sessions by device, Top landing pages |
| Sales (매출) | Sales over time, Sales by channel, Sales by product, Sales by staff |
| Customers (고객) | Customers over time, Returning customers, At-risk customers, Cohort analysis |
| Finance (재무) | Total sales, Payments, Taxes, Tips |
| Inventory (재고) | Inventory over time, ABC analysis by product, Month-end quantities |
| Marketing | Marketing attribution reports, UTM 기반 채널 성과 |
| Live View | 실시간 접속자, 실시간 매출 현황 |

**Shopify 플랜별 기능 차이:**
- Basic: 기본 60개 리포트 + 개요 대시보드
- Standard/Advanced: 코호트 분석, 커스텀 리포트 빌더, ShopifyQL 쿼리 에디터
- Plus: 전용 리포트, 고급 커스터마이징

**셀메이트CM 목표: Shopify Advanced 수준을 기본 제공 (플랜 구분 없이)**

---

## 2. 통계 데이터 수집 범위

### 2.1 셀메이트CM 자체 수집 데이터

서드파티에 의존하지 않고 플랫폼 자체에서 수집·보유하는 데이터 범위.

#### 2.1.1 트랜잭션 데이터 (주문/결제)

모든 결제 이벤트를 플랫폼 레이어에서 직접 캡처한다. GA4 연동과 무관하게 결제 완료 여부를 100% 기록하는 것이 핵심이다.

| 데이터 항목 | 설명 | 수집 시점 |
|-----------|------|---------|
| `order_id` | 주문 고유 ID | 주문 생성 시 |
| `transaction_id` | PG 결제 고유 ID | 결제 승인 시 |
| `gross_sales` | 할인 전 총 매출 | 주문 생성 시 |
| `discounts` | 쿠폰/할인 금액 합계 | 주문 생성 시 |
| `net_sales` | 할인 후 순 매출 (gross - discounts) | 주문 생성 시 |
| `returns` | 환불 금액 | 환불 처리 시 |
| `net_revenue` | 최종 순 수익 (net_sales - returns) | 실시간 계산 |
| `tax` | 세금 금액 | 주문 생성 시 |
| `shipping` | 배송비 | 주문 생성 시 |
| `payment_method` | 결제 수단 (카카오페이, 네이버페이, 신용카드 등) | 결제 승인 시 |
| `currency` | 결제 통화 | 주문 생성 시 |
| `exchange_rate` | 결제 시 환율 (다국가 정산) | 결제 승인 시 |
| `channel` | 판매 채널 (웹, 모바일앱, SNS 등) | 주문 생성 시 |
| `utm_source / medium / campaign` | UTM 파라미터 (세션에서 주문까지 연결) | 세션 시작 시 |
| `customer_id` | 주문자 고유 ID (비회원 포함 임시 ID 부여) | 주문 생성 시 |
| `is_first_order` | 첫 주문 여부 (신규 고객 판별) | 주문 생성 시 |
| `coupon_code` | 사용된 쿠폰 코드 | 주문 생성 시 |
| `line_items` | 구매 상품 목록 (상품 ID, 수량, 단가) | 주문 생성 시 |

#### 2.1.2 행동 데이터 (퍼널 추적)

셀메이트CM 자체 추적 스크립트 또는 SDK를 통해 수집. GA4와 중복 수집하되, 셀메이트CM 자체 데이터를 Primary로 사용한다.

| 이벤트 | GA4 대응 이벤트 | 수집 항목 |
|-------|--------------|---------|
| 상품 목록 조회 | `view_item_list` | list_name, items[] |
| 상품 상세 조회 | `view_item` | item_id, item_name, price, category |
| 장바구니 담기 | `add_to_cart` | item_id, quantity, price |
| 장바구니 제거 | `remove_from_cart` | item_id, quantity |
| 위시리스트 추가 | `add_to_wishlist` | item_id |
| 체크아웃 시작 | `begin_checkout` | cart_value, item_count, coupon |
| 배송 정보 입력 | `add_shipping_info` | shipping_tier |
| 결제 정보 입력 | `add_payment_info` | payment_type |
| 구매 완료 | `purchase` | transaction_id, value, tax, shipping, items[] |
| 환불 | `refund` | transaction_id, value, items[] |
| 검색 | `search` | search_term |
| 프로모션 노출 | `view_promotion` | promotion_id, promotion_name |
| 프로모션 클릭 | `select_promotion` | promotion_id, promotion_name |

**간편결제 완전 추적 방안 (카페24 핵심 약점 해소):**

카페24에서 간편결제 GA4 데이터가 누락되는 원인은 결제 리다이렉트 도중 GA4 `purchase` 이벤트 트리거가 실패하기 때문이다.

셀메이트CM 해결 방식:
1. 결제 완료 여부는 PG 웹훅(서버-서버)으로 확인 — 클라이언트 이벤트에 의존하지 않음
2. 서버에서 결제 완료 확인 즉시 `purchase` 이벤트를 Measurement Protocol (GA4 서버 사이드)으로 직접 전송
3. 클라이언트 리다이렉트 이후 결제 완료 페이지에서 중복 방지 체크 (transaction_id 기준 dedup)

#### 2.1.3 고객 데이터 (CRM)

| 데이터 항목 | 설명 |
|-----------|------|
| `customer_id` | 고유 고객 ID |
| `acquisition_date` | 첫 가입일 |
| `acquisition_channel` | 최초 유입 채널 |
| `first_order_date` | 첫 주문일 |
| `last_order_date` | 최근 주문일 |
| `total_orders` | 누적 주문 수 |
| `total_spent` | 누적 결제 금액 |
| `avg_order_value` | 평균 주문 금액 |
| `customer_segment` | RFM 기반 세그먼트 (VIP, 일반, 이탈 위험 등) |
| `country` | 국가 |
| `city` | 도시 |
| `device_type` | 주 사용 디바이스 |
| `marketing_opt_in` | 마케팅 수신 동의 여부 |

### 2.2 GA4 연동 데이터

GA4는 세션 수준 행동 분석 및 광고 어트리뷰션의 보조 데이터 소스로 활용한다. 셀메이트CM 자체 트랜잭션 데이터와 GA4 데이터를 연결할 수 있도록 `client_id`를 주문 데이터에 함께 저장한다.

| GA4 제공 데이터 | 활용 목적 |
|--------------|---------|
| Sessions by channel grouping | 채널별 유입 분석 |
| Engaged sessions | 실제 참여 세션 측정 |
| Bounce rate | 랜딩 페이지 품질 측정 |
| Session duration | 체류 시간 분석 |
| Page path + screen class | 인기 페이지 분석 |
| User acquisition (first touch) | 신규 고객 획득 채널 |
| Traffic acquisition (last touch) | 전환 직전 채널 |
| Google Ads 연동 데이터 | 광고 ROAS 측정 |
| Search Console 연동 | 자연 검색 유입 키워드 |

**GA4 데이터 접근 방식:**
- GA4 Data API (v1beta) 를 통해 주요 지표를 셀메이트CM 대시보드에 직접 임베드
- 머천트는 GA4 콘솔 접근 없이 셀메이트CM 어드민에서 GA4 데이터 확인 가능

### 2.3 MMP 수준 지표

Phase 3에서 모바일 앱을 출시하는 머천트를 위해 MMP(AppsFlyer 또는 Adjust) 수준의 어트리뷰션 데이터를 통합 제공한다.

**MMP가 제공하는 핵심 지표:**

| 지표 | 설명 |
|-----|------|
| Install attribution | 앱 설치를 유발한 광고/채널 |
| Re-engagement attribution | 기존 사용자 재참여 유발 채널 |
| ROAS by channel | 채널별 광고비 대비 매출 |
| Cost per install (CPI) | 설치당 비용 |
| Cost per purchase (CPP) | 구매 전환당 비용 |
| Day 1/7/30 retention | 설치 후 1/7/30일 유지율 |
| Cohort LTV | 획득 코호트별 누적 생애가치 |
| In-app purchase revenue | 앱 내 구매 매출 |
| Fraud detection | 어뷰징/광고 사기 탐지율 |

**Phase 3 통합 방식:**
- AppsFlyer 또는 Adjust MMP 파트너십 → SDK 내장
- MMP 대시보드 데이터를 셀메이트CM 어드민 API로 pull
- 웹 + 앱 통합 고객 여정 가시화

---

## 3. 대시보드 구성

### 3.1 어드민 홈 위젯 구성

어드민 로그인 직후 노출되는 메인 대시보드. 가장 중요한 KPI를 한눈에 파악할 수 있도록 구성한다. Shopify의 커스터마이징 가능한 위젯 방식을 채택한다.

**기본 위젯 구성 (머천트가 재배치/추가/제거 가능):**

```
┌─────────────────────────────────────────────────────────────────┐
│  오늘의 스냅샷 (실시간 업데이트)                                     │
├────────────┬────────────┬────────────┬────────────┬────────────┤
│  총 매출   │  주문 수   │  방문자 수  │ 전환율(CR)  │  AOV      │
│  ₩3.2M    │   48건    │   1,240명   │   3.9%    │  ₩66,667  │
│  +12% WoW │  +5% WoW  │  +8% WoW  │  -0.2%pp  │  +7% WoW  │
├────────────┴────────────┴────────────┴────────────┴────────────┤
│  매출 추이 차트 (기간 선택: 오늘/7일/30일/90일/커스텀)               │
├──────────────────────────────┬──────────────────────────────────┤
│  채널별 매출 비중 (파이 차트)  │  시간대별 주문 히트맵               │
├──────────────────────────────┼──────────────────────────────────┤
│  인기 상품 TOP 5              │  오늘 재고 부족 경고                │
├──────────────────────────────┼──────────────────────────────────┤
│  최근 주문 목록 (실시간)       │  AI 인사이트 (오늘의 요약)          │
└──────────────────────────────┴──────────────────────────────────┘
```

**핵심 KPI 위젯 목록 (Metrics Library):**

| 위젯 이름 | 지표 | 비교 기준 |
|---------|-----|---------|
| Total net sales | 순 매출 (반환 차감) | 전일/전주/전월 동기 대비 |
| Gross sales | 할인 전 총 매출 | 동기 대비 |
| Total orders | 주문 건수 | 동기 대비 |
| Average order value (AOV) | 주문당 평균 금액 | 동기 대비 |
| Sessions | 총 세션 수 | 동기 대비 |
| Unique visitors | 순 방문자 수 | 동기 대비 |
| Conversion rate | 세션 대비 구매 전환율 | 동기 대비 |
| Units sold | 판매 수량 | 동기 대비 |
| Returns | 환불 금액 | 동기 대비 |
| Net new customers | 신규 고객 수 | 동기 대비 |
| Returning customer rate | 재구매 고객 비율 | 동기 대비 |
| Customer acquisition cost (CAC) | 고객 획득 비용 (광고비 연동 필요) | 동기 대비 |
| Revenue by channel | 채널별 매출 분해 | 동기 대비 |
| Top products | 매출/수량 기준 인기 상품 | - |
| Inventory alerts | 재고 부족 상품 목록 | - |

### 3.2 실시간 현황판 (Live View)

Shopify의 Live View에 상응하는 실시간 모니터링 화면.

**제공 정보:**
- 현재 활성 방문자 수 (실시간 갱신, 30초 interval)
- 현재 장바구니에 상품이 담긴 세션 수
- 최근 1시간 주문 건수 및 매출
- 실시간 주문 알림 스트림 (국가, 금액, 상품)
- 방문자 지도 (접속 국가/도시 시각화)
- 인기 상품 실시간 조회 순위 (Top 5)

**기술 방식:**
- WebSocket 또는 SSE(Server-Sent Events)로 클라이언트에 푸시
- 방문자 집계: 셀메이트CM 자체 비콘 + GA4 Realtime API 병행

---

## 4. 리포트 카테고리별 지표 정의

### 4.1 매출 리포트

머천트가 가장 빈번하게 조회하는 핵심 리포트. 카페24의 기본 매출 통계보다 분해 수준을 높이고 비교 기간 기능을 강화한다.

#### 4.1.1 매출 개요

| 지표 | 정의 | 계산식 |
|-----|------|------|
| Gross sales | 할인 전 총 판매액 | SUM(unit_price × quantity) |
| Discounts | 적용된 할인 합계 | SUM(discount_amount) |
| Returns | 환불 처리된 금액 | SUM(refund_amount) |
| Net sales | 순 매출 | Gross sales - Discounts - Returns |
| Shipping | 배송비 수입 | SUM(shipping_amount) |
| Tax | 세금 수입 | SUM(tax_amount) |
| Total sales | 최종 결제액 합계 | Net sales + Shipping + Tax |
| Average order value | 주문당 평균 | Total sales / Total orders |
| Units sold | 총 판매 수량 | SUM(quantity) |
| Units per order | 주문당 평균 상품 수 | Units sold / Total orders |

**필터 옵션:** 기간, 채널, 결제 수단, 국가, 쿠폰 코드

**차트 형태:** 기간별 추이 (일/주/월 집계), 전기 대비 오버레이

#### 4.1.2 채널별 매출 분해

| 채널 구분 | 설명 |
|---------|------|
| Online store (직접) | 스토어 직접 방문 |
| Social commerce | 인스타그램, 페이스북 등 |
| Naver Smart Store | 네이버 스마트스토어 연동 |
| Kakao Channel | 카카오 쇼핑 연동 |
| Mobile App | 머천트 전용 앱 |
| POS | 오프라인 판매 (향후) |
| API / Headless | 외부 채널 API 주문 |

#### 4.1.3 결제 수단별 매출

| 결제 수단 | 수집 항목 |
|---------|---------|
| 신용/체크카드 | 카드사별 분류 |
| 카카오페이 | 건수, 금액 |
| 네이버페이 | 건수, 금액 |
| 토스페이 | 건수, 금액 |
| 무통장입금 | 건수, 금액 |
| PayPay (일본) | 건수, 금액 |
| 콘비니 (일본) | 건수, 금액 |
| Stripe (글로벌) | 건수, 금액, 통화 |

### 4.2 고객 리포트

#### 4.2.1 고객 획득 분석

| 지표 | 정의 |
|-----|------|
| New customers | 기간 내 첫 주문 고객 수 |
| Returning customers | 기간 내 2회 이상 주문 고객 수 |
| Returning customer rate | Returning / Total customers × 100 |
| Customer acquisition cost (CAC) | 마케팅 지출 / New customers (광고 연동 시) |
| Time to first purchase | 가입일 → 첫 구매일 평균 소요 기간 |

#### 4.2.2 고객 LTV 분석

| 지표 | 정의 | 계산식 |
|-----|------|------|
| Customer lifetime value (LTV) | 고객 1명의 누적 기대 매출 | AOV × Purchase frequency × Customer lifespan |
| Average purchase frequency | 기간 내 평균 구매 횟수 | Total orders / Unique customers |
| Average customer lifespan | 첫 구매~마지막 구매 평균 기간 | - |
| LTV:CAC ratio | LTV 대비 획득 비용 비율 | LTV / CAC (3 이상이 건강한 수준) |

#### 4.2.3 코호트 분석 (Phase 2)

획득 월(cohort)별로 고객의 재구매율을 시각화한다. Shopify Standard 이상에서 제공하는 기능을 셀메이트CM는 기본 제공한다.

**코호트 테이블 형식:**

```
획득 월    | 고객수 | Month 0 | Month 1 | Month 2 | Month 3 | ...
----------|-------|---------|---------|---------|---------|----
2025-10   |  324  |  100%   |  18%    |  12%    |   9%    |
2025-11   |  287  |  100%   |  21%    |  14%    |   -     |
2025-12   |  412  |  100%   |  19%    |   -     |   -     |
```

**지원 코호트 지표:**
- 재구매율 (Repeat purchase rate)
- 코호트 누적 매출 (Cumulative revenue per cohort)
- 코호트 LTV 추이

#### 4.2.4 RFM 세그먼테이션 (Phase 2)

| 세그먼트 | 정의 | 권장 액션 |
|---------|------|---------|
| Champions | 최근 구매, 고빈도, 고금액 | VIP 대우, 신제품 선공개 |
| Loyal customers | 고빈도, 고금액 | 로열티 프로그램 강화 |
| Potential loyalists | 최근 구매, 중간 빈도 | 업셀/크로스셀 |
| At risk | 과거 고빈도이나 최근 미구매 | 재활성 캠페인 |
| Lost customers | 오랜 기간 미구매 | 파격 혜택 또는 정리 |

### 4.3 상품 리포트

#### 4.3.1 상품 성과

| 지표 | 정의 |
|-----|------|
| Units sold | 상품별 판매 수량 |
| Gross sales by product | 상품별 매출 |
| Net sales by product | 상품별 순 매출 (환불 차감) |
| Return rate by product | 상품별 환불률 (환불 수량 / 판매 수량) |
| Average selling price | 상품별 평균 판매가 (할인 적용 후) |
| Gross margin by product | 상품별 매출총이익률 (원가 입력 시) |

#### 4.3.2 재고 분석

| 지표 | 정의 |
|-----|------|
| Inventory quantity | 현재 재고 수량 |
| Days of inventory remaining | 현재 재고 소진 예상 일수 (일평균 판매량 기준) |
| Sell-through rate | 판매율 (판매 수량 / (판매 + 재고) × 100) |
| ABC analysis | A(상위 20% 매출), B(중간), C(하위) 상품 분류 |
| Stockout events | 재고 소진 발생 횟수 및 기간 |

#### 4.3.3 장바구니 분석

| 지표 | 정의 |
|-----|------|
| Cart add rate | 상품 조회 대비 장바구니 추가율 |
| Cart abandonment rate | 장바구니 추가 후 미구매 비율 |
| Cart abandonment value | 미구매 장바구니 총 금액 |
| Top abandoned products | 장바구니에 담겼으나 미구매된 상품 TOP |
| Checkout abandonment rate | 체크아웃 시작 후 미완료 비율 |

### 4.4 마케팅 채널 리포트

#### 4.4.1 채널별 유입/전환 분석

GA4 Data API + 자체 UTM 추적을 결합하여 제공.

| 지표 | 정의 |
|-----|------|
| Sessions by channel | 채널별 세션 수 |
| New users by channel | 채널별 신규 사용자 수 |
| Conversion rate by channel | 채널별 구매 전환율 |
| Revenue by channel | 채널별 기여 매출 |
| Revenue per session | 세션당 매출 |
| ROAS by channel | 광고비 대비 매출 (광고 플랫폼 연동 시) |

**지원 채널 분류 (Google 채널 그룹핑 기준 적용):**

| 채널 | 예시 |
|-----|------|
| Organic Search | 네이버, 구글 자연 검색 |
| Paid Search | 네이버 검색광고, 구글 Ads |
| Organic Social | 인스타그램, 카카오스토리 자연 게시 |
| Paid Social | 인스타그램 광고, 카카오 광고 |
| Email | 뉴스레터, CRM 발송 |
| Referral | 외부 사이트 링크 |
| Direct | 직접 유입 (북마크, URL 직접 입력) |
| Affiliate | 제휴 마케팅 |
| SMS | 문자 마케팅 |
| KakaoTalk Channel | 카카오 채널 메시지 |

#### 4.4.2 쿠폰/할인 효과 분석

| 지표 | 정의 |
|-----|------|
| Coupon usage count | 쿠폰별 사용 횟수 |
| Coupon revenue | 쿠폰 사용 주문의 매출 |
| Average discount per order | 주문당 평균 할인액 |
| Discount as % of gross sales | 매출 대비 할인 비율 |
| New customer ratio by coupon | 쿠폰별 신규 고객 획득 비율 |

### 4.5 전환 퍼널 리포트

카페24의 가장 큰 약점 중 하나인 퍼널 분석을 Phase 1 MVP에 포함한다.

#### 4.5.1 표준 구매 퍼널

```
세션 시작
    │ 세션 수: N
    ▼
상품 조회 (view_item)
    │ 상품 조회율: N%
    ▼
장바구니 추가 (add_to_cart)
    │ 장바구니 추가율: N%     ← 이탈: N%
    ▼
체크아웃 시작 (begin_checkout)
    │ 체크아웃 진입율: N%     ← 이탈: N%
    ▼
배송 정보 입력 (add_shipping_info)
    │ 배송 정보 입력율: N%    ← 이탈: N%
    ▼
결제 정보 입력 (add_payment_info)
    │ 결제 정보 입력율: N%    ← 이탈: N%
    ▼
구매 완료 (purchase)
    최종 전환율: N%
```

**각 단계별 제공 지표:**
- 단계별 사용자 수
- 단계 진입률 (전 단계 대비)
- 단계 이탈률 (전 단계 대비)
- 단계 간 평균 소요 시간
- 이탈 사용자의 재방문율

**필터:** 기간, 디바이스 유형, 채널, 고객 세그먼트 (신규/재구매)

#### 4.5.2 체크아웃 단계 상세

| 지표 | 정의 |
|-----|------|
| Checkout initiation rate | 장바구니 방문 대비 체크아웃 시작 비율 |
| Checkout completion rate | 체크아웃 시작 대비 결제 완료 비율 |
| Payment method abandonment | 결제 수단별 이탈율 (결제 실패 추적) |
| Average time to checkout | 장바구니 추가 ~ 결제 완료 평균 시간 |

---

## 5. GA4 통합 방식

### 5.1 통합 방식 비교 (API vs iframe vs 직접 수집)

| 방식 | 장점 | 단점 | 적합도 |
|-----|------|------|------|
| **GA4 Data API** | GA4 데이터를 셀메이트CM UI에 네이티브 통합 가능. 머천트가 GA4 콘솔 몰라도 됨 | API 할당량 제한(일 200k 요청). GA4 연결 설정 필요 | 높음 |
| **GA4 iframe 임베드** | 구현 간단. GA4 리포트 그대로 노출 | 셀메이트CM 디자인과 불일치. 머천트가 GA4 계정 필요. 커스터마이징 불가 | 낮음 |
| **직접 수집 (자체 비콘)** | GA4 의존도 없음. 완전한 데이터 소유권 | GA4와 별도 데이터 파이프라인 구축 비용 큼. 광고 어트리뷰션 한계 | 중간 (보완 수단) |
| **Measurement Protocol** | 서버 사이드 이벤트 전송 가능. 간편결제 추적 완결 | GA4 API와 조합 필요. 설정 복잡 | 높음 (간편결제용) |

### 5.2 권장 방식 및 근거

**권장: GA4 Data API + Measurement Protocol 혼합 방식**

```
[셀메이트CM 자체 수집 레이어]
        ↕ 트랜잭션 이벤트 (Measurement Protocol)
[GA4]  ←→  [GA4 Data API]  →  [셀메이트CM 어드민 대시보드]
        ↑
[클라이언트 비콘] (gtag.js / GTM)
```

**구체적 역할 분담:**

| 수집 주체 | 수집 데이터 | 활용 목적 |
|---------|-----------|---------|
| 클라이언트 gtag.js | 페이지뷰, 세션, 행동 이벤트 | GA4 기본 리포트 |
| 서버 Measurement Protocol | 결제 완료 이벤트 (간편결제 포함) | 구매 전환 완전 추적 |
| GA4 Data API | 채널 분석, 행동 데이터 Pull | 셀메이트CM 대시보드 통합 표시 |
| 셀메이트CM DB | 모든 주문/결제/고객 데이터 | Primary Source of Truth |

**근거:**
1. GA4 Data API는 머천트가 GA4 콘솔을 별도로 학습할 필요 없이 셀메이트CM 어드민에서 모든 분석을 완결할 수 있게 한다
2. Measurement Protocol은 간편결제 리다이렉트 이후 발생하는 데이터 누락을 서버 사이드에서 완전 해소한다
3. 셀메이트CM DB를 Primary로 유지함으로써 GA4 데이터 오차 발생 시에도 정확한 매출 수치를 확보한다

**GA4 연동 온보딩 (머천트 설정 최소화):**
1. GA4 측정 ID 입력 (1개 필드)
2. 셀메이트CM가 gtag.js 자동 삽입 + 권장 이벤트 자동 설정
3. Measurement Protocol용 API Secret 자동 생성 및 저장
4. 서버 사이드 이벤트 전송 자동 활성화

---

## 6. 기술 요건

### 6.1 실시간 vs 배치 처리 기준

| 데이터 유형 | 처리 방식 | 지연 허용 범위 | 근거 |
|-----------|---------|-------------|------|
| 주문/결제 이벤트 | 실시간 스트리밍 | < 1초 | 라이브 뷰, 즉시 재고 반영 필요 |
| 세션/방문자 수 | 실시간 집계 | < 30초 | 라이브 뷰 정확도 |
| 매출 KPI (오늘) | 5분 배치 | < 5분 | 대시보드 홈 위젯 |
| 일별 리포트 | 야간 배치 | < 24시간 | 리포트 정확도 우선 |
| 코호트 분석 | 일별 배치 | < 24시간 | 계산량 큼, 실시간 불필요 |
| GA4 데이터 Pull | 3시간 배치 | < 3시간 | GA4 API 할당량 절약 |
| RFM 세그먼테이션 | 일별 배치 | < 24시간 | 계산 비용 고려 |

**실시간 파이프라인 기술 후보:**
- 주문 이벤트: PostgreSQL NOTIFY + 애플리케이션 레이어 WebSocket
- 대용량 이벤트: AWS Kinesis 또는 Kafka (Phase 2 이후)
- 라이브 뷰: SSE(Server-Sent Events) 우선, 이후 WebSocket으로 전환

### 6.2 데이터 보존 기간 정책

| 데이터 유형 | 보존 기간 | 저장소 |
|-----------|---------|------|
| 주문/결제 원본 데이터 | 무기한 (법적 의무 5년 이상) | PostgreSQL (멀티테넌트 스키마) |
| 세션/행동 이벤트 로그 | 13개월 (GA4 기본 정책 준수) | 콜드 스토리지 (S3 등) |
| 일별 집계 스냅샷 | 3년 | PostgreSQL |
| 월별 집계 스냅샷 | 무기한 | PostgreSQL |
| 실시간 집계 캐시 | 24시간 | Redis |
| GA4 Pull 캐시 | 3시간 | Redis |

### 6.3 데이터 파이프라인 개요

```
[데이터 수집]                    [저장]                  [서빙]

클라이언트 이벤트 ──────────────▶ 이벤트 큐 ───────────▶ 집계 엔진
(gtag.js, 자체 비콘)             (Kinesis/Kafka)        (배치/스트림)
                                                            │
서버 이벤트 ─────────────────────▶ 주문 DB ───────────────▶ 집계 DB
(Measurement Protocol,           (PostgreSQL)           (읽기 전용)
 PG 웹훅)                                                   │
                                                            ▼
GA4 Data API ────────────────────▶ 캐시 ───────────────▶ API Layer
(3시간 배치 Pull)                (Redis)                    │
                                                            ▼
                                                       어드민 대시보드
                                                       (Next.js)
```

**멀티테넌시 고려사항:**
- 고객사별 데이터 스키마 분리 (PostgreSQL schema-per-tenant)
- 집계 쿼리는 고객사 간 격리 보장
- VIP 고객사는 전용 읽기 전용 DB replica 제공 (Enterprise 플랜)

**API 설계 원칙:**
- 어드민 대시보드용 Analytics API는 `GET /api/v1/analytics/` 하위로 구성
- 모든 응답에 `data_updated_at` 타임스탬프 포함 (데이터 신선도 표시)
- 응답 캐싱: ETag 활용, 5분 캐시 기본 (실시간 엔드포인트 제외)

---

## 7. 구현 우선순위

### Phase 1 — MVP (출시 전 필수)

목표: 카페24보다 확실히 나은 기본 통계. 데이터 정합성 완전 보장.

| 기능 | 설명 | 우선순위 |
|-----|------|---------|
| 주문/결제 데이터 100% 수집 | 간편결제 포함, 서버 사이드 캡처 | 최우선 |
| Measurement Protocol 연동 | 간편결제 GA4 누락 방지 | 최우선 |
| 어드민 홈 대시보드 | 기본 KPI 위젯 (매출, 주문, 방문자, 전환율) | 최우선 |
| 매출 리포트 | 기간별/채널별/결제수단별 매출 분해 | 높음 |
| 상품 리포트 | 판매 순위, 반품율, 재고 현황 | 높음 |
| 전환 퍼널 | 5단계 표준 구매 퍼널, 단계별 이탈율 | 높음 |
| GA4 기본 연동 | 측정 ID 입력 → 자동 이벤트 설정 | 높음 |
| 실시간 현황판 (Live View) | 현재 방문자, 오늘 주문 스트림 | 중간 |
| 고객 기본 리포트 | 신규/재구매 고객 수, 지역별 분포 | 중간 |
| 쿠폰 효과 분석 | 쿠폰별 사용 건수, 기여 매출 | 중간 |
| 데이터 내보내기 (CSV) | 모든 리포트 CSV 다운로드 | 중간 |

**Phase 1 제외 항목 (의도적 제외):**
- 코호트 분석 (Phase 2)
- RFM 세그먼테이션 (Phase 2)
- 커스텀 리포트 빌더 (Phase 2)
- A/B 테스트 (Phase 3)
- MMP 연동 (Phase 3)

### Phase 2 — 고도화 (출시 후 3~6개월)

목표: Shopify Advanced 이상의 분석 기능. 고급 사용자 이탈 방지.

| 기능 | 설명 |
|-----|------|
| 코호트 분석 | 획득 월별 재구매율 테이블 |
| RFM 세그먼테이션 | Champions, At-risk 등 자동 분류 |
| 고객 LTV 계산 | AOV × 빈도 × 기간 기반 LTV |
| 커스텀 리포트 빌더 | 드래그앤드롭으로 원하는 지표 조합 |
| 마케팅 어트리뷰션 | UTM 기반 멀티터치 어트리뷰션 (Last touch / First touch / Linear) |
| 벤치마크 비교 | 동업종 평균 전환율/AOV와 내 수치 비교 |
| AI 인사이트 자동 생성 | 주간 매출 변화 원인 AI 자동 분석 및 요약 |
| 알림 자동화 | 매출 급등/급락, 재고 부족, 이탈 위험 고객 알림 |
| 일본어 리포트 지원 | 일본 머천트 전용 UI 현지화 |

### Phase 3 — MMP 수준 (출시 후 12개월 이상)

목표: 앱 출시 머천트 대상 모바일 어트리뷰션까지 통합.

| 기능 | 설명 |
|-----|------|
| AppsFlyer / Adjust 연동 | MMP SDK 내장, 설치 어트리뷰션 |
| 웹+앱 통합 고객 여정 | 앱 설치 → 웹 구매 크로스 디바이스 추적 |
| In-app purchase 분석 | 앱 내 구매 이벤트 통합 |
| A/B 테스트 플랫폼 | 랜딩페이지, 가격, 배너 A/B 테스트 내장 |
| 예측 분석 | 이탈 예측, LTV 예측 (ML 모델) |
| ShopifyQL 상당 쿼리 에디터 | SQL-like 언어로 커스텀 분석 |
| Data Export API | BigQuery, Looker Studio 직접 연동 |

---

## 8. 경쟁 우위 포인트

### 8.1 카페24 대비

| 항목 | 카페24 | 셀메이트CM | 차별화 포인트 |
|-----|-------|----------|-----------|
| 통계 집계 주기 | 1시간 | 실시간 (주문) + 5분 (KPI) | 즉각적 의사결정 가능 |
| 간편결제 추적 | GA4 연동 시 빈번 누락 | Measurement Protocol로 100% 추적 | 데이터 신뢰성 확보 |
| 통계 수치 정합성 | GA4 vs 카페24 간 불일치 | 셀메이트CM DB = Single Source of Truth | 수치 혼란 제거 |
| 전환 퍼널 분석 | 제한적 | Phase 1 기본 제공 | 이탈 지점 즉시 파악 |
| 코호트 분석 | 없음 | Phase 2 기본 제공 | 재구매율 전략 수립 |
| 커스텀 리포트 | 없음 | Phase 2 제공 | 원하는 지표 자유 조합 |
| AI 인사이트 | 없음 | Phase 2 제공 | 데이터 해석 자동화 |

### 8.2 Shopify 대비 (한국/일본 시장 맥락)

| 항목 | Shopify | 셀메이트CM | 차별화 포인트 |
|-----|--------|----------|-----------|
| 간편결제 추적 | 한국/일본 간편결제 불완전 | 로컬 PG 완전 연동 | 국내 결제 데이터 완전성 |
| 결제 수단별 분석 | 기본 제공 | 카카오페이/네이버페이/콘비니 세분화 | 로컬 결제 인사이트 |
| 국내 광고 채널 연동 | 네이버/카카오 광고 공식 미지원 | 네이버 광고, 카카오 광고 기본 연동 | 국내 마케팅 성과 추적 |
| 한/일 언어 리포트 | 영어 기반 | 한국어/일본어 완전 지원 | 운영자 진입 장벽 제거 |
| 벤치마크 데이터 | 글로벌 기준 | 한국/일본 업종별 벤치마크 | 로컬 맥락의 비교 가능 |

### 8.3 핵심 차별화 메시지

> "통계가 틀리면 의사결정도 틀린다. 셀메이트CM는 간편결제까지 100% 추적되는 첫 번째 한국 이커머스 플랫폼이다."

> "GA4를 몰라도 됩니다. 매일 아침 AI가 어제 매출의 원인을 설명해드립니다."

---

## 부록 A. 지표 용어 정의

| 용어 | 영문 | 정의 |
|-----|------|------|
| 세션 | Session | 사용자가 스토어에 접속해 일정 시간(30분) 내에 연속된 행동의 단위 |
| 전환율 | Conversion Rate (CVR) | 총 세션 중 구매 완료 세션의 비율 |
| 평균 주문 금액 | Average Order Value (AOV) | 총 매출 / 총 주문 건수 |
| 신규 고객 | New Customer | 해당 기간 내 처음 구매한 고객 |
| 재구매 고객 | Returning Customer | 해당 기간 내 2회 이상 구매한 고객 |
| 고객 생애가치 | Customer Lifetime Value (LTV) | 한 고객이 전체 관계 기간 동안 창출하는 예상 총 매출 |
| 코호트 | Cohort | 특정 기간에 동일한 경험(예: 첫 구매)을 공유한 고객 그룹 |
| 이탈율 | Bounce Rate | 세션 중 추가 상호작용 없이 스토어를 떠난 비율 |
| RFM | Recency, Frequency, Monetary | 최근성, 빈도, 금액 기반 고객 가치 세그먼테이션 모델 |
| ROAS | Return On Ad Spend | 광고비 대비 매출 비율 (매출 / 광고비) |
| CAC | Customer Acquisition Cost | 신규 고객 1명 획득에 소요된 마케팅 비용 |
| MMP | Mobile Measurement Partner | 모바일 광고 어트리뷰션 및 앱 성과 측정 전문 플랫폼 |

## 부록 B. 개발 시 참고 API 및 문서

- GA4 Data API: https://developers.google.com/analytics/devguides/reporting/data/v1
- GA4 Measurement Protocol: https://developers.google.com/analytics/devguides/collection/protocol/ga4
- GA4 권장 이커머스 이벤트: https://developers.google.com/analytics/devguides/collection/ga4/ecommerce
- Shopify Analytics 공식 문서: https://help.shopify.com/en/manual/reports-and-analytics/shopify-reports
- AppsFlyer eCommerce 솔루션: https://www.appsflyer.com/solutions/ecommerce/
