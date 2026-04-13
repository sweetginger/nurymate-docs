# Shopify ShopifyQL 쿼리 기반 보고서 기능 조사 [11-11]

> 조사일: 2026-03-10 | 목적: 셀메이트CM 통계·분석 기능 방향성 결정

---

## 1. 기능 개요: ShopifyQL이란?

ShopifyQL은 Shopify가 자체 개발한 **커머스 전용 쿼리 언어**로, SQL과 유사한 문법으로 스토어의 판매·고객·재고·마케팅 데이터를 조회·시각화할 수 있는 도구다. 2022년 처음 도입되었으며, 2024 Winter Editions에서 모든 보고서 화면에서 직접 접근 가능하도록 확장되었다.

### 1-1. 주요 쿼리 문법 특징

- **SQL 유사 구조**: `FROM`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT` 등 친숙한 키워드 지원
- **COMPARE TO 키워드**: 기간 비교 분석을 단일 키워드로 처리
  - 예: `COMPARE TO previous_period` → 자동으로 이전 기간 데이터 병렬 조회
- **커머스 전용 날짜 함수**: `day_of_week()`, `week_of_year()`, `month()` 등 이커머스에 최적화된 시간 함수
- **내장 시각화**: 쿼리 결과를 바 차트, 라인 차트 등으로 즉시 렌더링

### 1-2. 접근 경로

| 방법 | 설명 | 대상 |
|------|------|------|
| Shopify Admin 보고서 화면 | Winter 2025 이후 모든 보고서에서 ShopifyQL 에디터 버튼 제공 | Advanced/Plus |
| ShopifyQL Notebooks | Jupyter Notebook형 인터페이스, 쿼리+메모 혼합 | Plus 전용 |
| GraphQL Admin API | `shopifyqlQuery` 뮤테이션으로 외부 앱·스크립트에서 호출 | API 접근 가능 개발자 |
| Python·코드 에디터 | API를 통해 프로그래매틱 쿼리 실행 | 개발자 |

### 1-3. 접근 가능한 데이터 모델

ShopifyQL에서 쿼리 가능한 주요 테이블(데이터 모델):

- `sales` — 주문·매출·환불 데이터
- `customers` — 고객 정보, LTV, 세그먼트
- `products` — 상품·SKU별 판매 성과
- `sessions` — 세션 트래픽 (제한적)
- `inventory` — 재고 수준 (최근 90일 한정)
- `marketing` — 마케팅 채널별 성과

---

## 2. 이점 및 강점

### 2-1. 커스텀 지표 생성 자유도

- 기본 제공 보고서로 해결되지 않는 복합 지표 생성 가능
  - 예: 특정 SKU의 반복 구매율 × 평균 주문 금액 × 고객 코호트 조합
- 다수의 필터·조건을 중첩하여 매우 세밀한 세그먼트 분석 가능

### 2-2. 기간 비교 분석 내장

- `COMPARE TO previous_period`, `COMPARE TO previous_year` 키워드로 복잡한 피리어드 오버피리어드 분석을 2줄로 처리
- 별도 Excel 가공 없이 Shopify Admin 내에서 즉시 시각화

### 2-3. GraphQL API 연동으로 확장성

- 외부 BI 툴(Looker, Tableau, Metabase 등)에서 ShopifyQL 결과를 직접 호출하여 대시보드 구성 가능
- 자체 앱·스크립트와 통합하여 자동화 리포팅 파이프라인 구성

### 2-4. 빠른 프로토타이핑

- 개발자·분석가가 새로운 지표를 Ad-hoc으로 빠르게 테스트 가능
- ShopifyQL Notebooks에서 쿼리 + 분석 설명을 한 화면에 작성하여 팀 공유 용이

---

## 3. 단점 및 한계

### 3-1. 비기술 사용자 진입 장벽 (가장 큰 문제)

- ShopifyQL은 "SQL을 알면 쉽다"고 소개되지만, **이커머스 운영자 대다수는 SQL을 모름**
- 비기술 창업자, 마케터, Growth 담당자가 직접 사용하기 어렵고, 데이터 분석가 지원이 필요
- 셀메이트CM 타겟 사용자(한국 소규모 쇼핑몰 운영자)에게는 특히 높은 장벽

### 3-2. 테이블 조인 제한

- 표준 SQL과 달리 **임의 테이블 간 JOIN 불가** — Shopify가 허용하는 사전 정의된 관계만 조회 가능
- 예: `sessions` 테이블과 `sales` 테이블을 직접 JOIN하여 방문-전환 경로를 분석하는 것이 불가능
- 이로 인해 복잡한 멀티터치 분석은 외부 툴(Triple Whale, Northbeam 등)에 의존해야 함

### 3-3. 외부 데이터 소스 연결 불가

- ShopifyQL은 Shopify 내부 데이터만 조회 가능
- Google Ads, Meta, Klaviyo 등 외부 플랫폼 데이터와 통합 불가
- 통합 분석을 원하면 별도 BI 툴 또는 써드파티 애널리틱스 앱 필요

### 3-4. 데이터 보관 기간 제한

- 시간별(hourly) 판매 보고서: **최근 7일만** 조회 가능
- 재고 수준 이력: **최근 90일 한정**
- 이커머스 시즌 비교 분석(작년 동기 대비 등)은 별도 데이터 추출·보관 필요

### 3-5. 플랜 제한 (이용 자격)

| 기능 | 제공 플랜 |
|------|---------|
| 기본 ShopifyQL 에디터 | Advanced, Plus |
| ShopifyQL Notebooks | **Plus 전용** ($2,300+/월) |
| GraphQL API ShopifyQL 쿼리 | 모든 플랜 (기술적 접근) |
| 커스텀 보고서 빌더 | Advanced 이상 |

- Basic, Grow 플랜 사용자는 ShopifyQL 에디터에 접근 자체가 불가
- 중소 판매자의 대다수가 Basic·Grow를 사용하므로 실제 이용률은 낮음

### 3-6. 쿼리 오류 디버깅 어려움

- 오류 메시지가 직관적이지 않아 비전문가가 수정하기 어렵다는 피드백 다수
- 커뮤니티 지원(Shopify Community, Reddit r/shopify)에도 ShopifyQL 오류 관련 질문이 빈번

---

## 4. 실제 사용자 피드백 및 커뮤니티 반응

### 4-1. 긍정적 평가

- "ShopifyQL은 Plus 판매자에게 정말 강력하다. COMPARE TO 하나로 이전에 몇 시간 걸리던 분석을 분 단위로 처리한다" — Shopify Community 파트너 포럼
- "기술팀이 있는 브랜드라면 ShopifyQL Notebooks는 내부 BI 툴 대체가 가능한 수준" — eCom 에이전시 블로그
- Winter 2025 업데이트 이후 보고서 화면 내 직접 접근 가능해져 접근성 개선 호평

### 4-2. 부정적 평가 / 한계 지적

- "SQL을 조금 알아도 ShopifyQL에서 원하는 JOIN을 못 해서 결국 Triple Whale 썼다" — Reddit r/shopify
- "Plus 전용 Notebooks는 플랜 업그레이드를 강요받는 느낌. $2,300/월 장벽은 너무 높다" — 중소 셀러 포럼
- "데이터 보관 기간이 짧아서 장기 트렌드 분석이 사실상 불가능. 별도로 데이터를 쌓아야 한다" — 기술 블로그
- "비즈니스 오너가 직접 쓰기엔 SQL 지식이 필요해서 결국 마케터는 못 쓰고 개발자만 쓴다" — 에이전시 커뮤니티

### 4-3. 대안 툴 사용 현황

ShopifyQL의 한계를 보완하기 위해 실제 사용자들이 선택하는 대안:

| 니즈 | 대안 툴 |
|------|--------|
| 멀티채널 어트리뷰션 | Triple Whale, Northbeam, Rockerbox |
| 통합 BI | Google Looker Studio, Tableau, Metabase |
| 이메일·SMS 분석 | Klaviyo, Omnisend |
| 심층 분석 + AI | Polar Analytics, Luca |

---

## 5. 셀메이트CM 통계 기능 설계 시 방향성 시사점

### 5-1. ShopifyQL 방식의 직접 채택 여부: 비추천

- 한국 소규모·중소 이커머스 운영자는 SQL 친숙도가 극히 낮음
- 쿼리 방식은 고급 사용자 전용 부가 기능으로만 제한 제공이 적절
- 핵심 통계 UI는 **노코드 대시보드** 방식(클릭·드래그 기반)으로 설계해야 함

### 5-2. ShopifyQL을 '대안'으로 포지셔닝: 일부 채택 가능

- 파워 유저(데이터 분석가, 기술 창업자) 대상으로 **쿼리 에디터를 고급 기능으로 별도 제공** 가능
- 기본 사용자: 노코드 UI → 고급 사용자: SQL/쿼리 에디터 2트랙 제공이 최적 전략

### 5-3. '보완'이 핵심: ShopifyQL이 못하는 것을 셀메이트CM이 해야

ShopifyQL의 구조적 한계를 역이용하여 차별화 포인트 설계:

| ShopifyQL 한계 | 셀메이트CM 차별화 방향 |
|---------------|---------------------|
| 외부 데이터 소스 연결 불가 | 카카오 광고, 네이버 광고, 쿠팡 등 국내 채널 데이터 통합 대시보드 |
| 비기술 사용자 접근 불가 | 자연어 입력 → 자동 차트 생성 (AI 어시스턴트) |
| 데이터 보관 기간 제한 | 전체 이력 무제한 보관 (플랜별 조회 기간 차등) |
| 멀티터치 어트리뷰션 불가 | 국내 마케팅 채널 기여도 분석 내재화 |

### 5-4. 플랜 잠금 전략 참고

- Shopify는 ShopifyQL을 Advanced/Plus에만 열어 업그레이드 유도
- 셀메이트CM도 **기본 통계(무료 또는 초급 플랜)** + **고급 분석·커스텀 대시보드(중상위 플랜)** 차등 제공으로 자연스러운 업셀링 레버 활용 가능

---

*Sources:*
- [ShopifyQL Syntax Reference - Shopify Dev](https://shopify.dev/docs/api/shopifyql)
- [Using ShopifyQL - Shopify Help Center](https://help.shopify.com/en/manual/reports-and-analytics/shopify-reports/report-types/shopifyql-editor)
- [Introducing ShopifyQL - Shopify Engineering](https://shopify.engineering/shopify-commerce-data-querying-language-shopifyql)
- [Is ShopifyQL Worth Using - Root Syntax](https://www.rootsyntax.com/blogs/news/is-shopifyql-worth-using-for-your-store-s-analytics-in-2025)
- [Shopify Analytics Complete Guide 2026 - Luca](https://ask-luca.com/blogs/shopify-analytics-guide)
- [Comparing Shopify Plans 2025 - Analyzify](https://analyzify.com/hub/comparing-shopify-plans)
