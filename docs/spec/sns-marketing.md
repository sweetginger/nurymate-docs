# SNS 마케팅 연동 기능 기획서 [6-8]

> 작성일: 2026-03-10 | 버전: v0.1
> 관련 조사: research/sns-integration.md

---

## 목차

1. [개요 및 목적](#1-개요-및-목적)
2. [SNS 채널 통합 관리 UI 기획](#2-sns-채널-통합-관리-ui-기획)
3. [상품 카탈로그 자동 동기화 기획](#3-상품-카탈로그-자동-동기화-기획)
4. [광고 성과 통합 대시보드](#4-광고-성과-통합-대시보드)
5. [인스타그램 Shopping 태그 자동화](#5-인스타그램-shopping-태그-자동화)
6. [플랫폼별 API 연동 방식 및 개발 요구사항](#6-플랫폼별-api-연동-방식-및-개발-요구사항)
7. [단계별 구현 로드맵](#7-단계별-구현-로드맵)
8. [경쟁사 대비 차별화 포인트](#8-경쟁사-대비-차별화-포인트)
9. [리스크 및 대응 방안](#9-리스크-및-대응-방안)
10. [인스타그램 데이터 연동 분석](#10-인스타그램-데이터-연동-분석-관련-태스크-15-3)

---

## 1. 개요 및 목적

### 1.1 기능 목적

누리메이트 셀러가 인스타그램, 페이스북, 틱톡 등 SNS 채널을 자사몰과 연동하여 상품 카탈로그를 자동 동기화하고, 광고 성과를 통합 분석하며, SNS에서 자사몰로의 구매 전환을 극대화할 수 있도록 지원한다.

### 1.2 타겟 셀러 시나리오

- **인스타그램 기반 패션 셀러**: 팔로워 1만+, 기존에 DM으로 주문 받던 방식에서 자사몰 전환 희망
- **TikTok Shop 병행 운영 셀러**: 숏폼 영상으로 트래픽을 자사몰로 유도하고 싶음
- **일본 진출 셀러**: 일본 SNS 환경(LINE, Instagram)에서 판매 채널 확장 희망

### 1.3 연동 채널 우선순위

| 우선순위 | 채널 | 이유 |
|---------|------|------|
| P1 (MVP) | Meta (Instagram + Facebook) | 한국·일본 D2C 셀러 주요 채널 |
| P1 (MVP) | TikTok Shop | 급성장 채널, 한국·일본 모두 활성화 |
| P2 | Pinterest | 패션·인테리어 셀러 주요 채널 |
| P2 | LINE (일본) | 일본 셀러 핵심 커뮤니케이션 채널 |
| P3 | YouTube Shopping | 영상 커머스 성장 추세 |

---

## 2. SNS 채널 통합 관리 UI 기획

### 2.1 SNS 연동 허브 화면 (셀러 어드민)

```
+=========================================================================+
|  SNS 마케팅 연동                                                         |
+=========================================================================+
|  연결된 채널 (2/5)                                                       |
+=========================================================================+
|                                                                         |
|  +-------------------+  +-------------------+  +-------------------+   |
|  | [IG 아이콘]        |  | [FB 아이콘]        |  | [TK 아이콘]        |  |
|  | Instagram         |  | Facebook          |  | TikTok Shop       |  |
|  | ● 연결됨          |  | ● 연결됨          |  | ○ 미연결          |  |
|  | @myfashion_kr     |  | MyFashion Page    |  |                   |  |
|  | 팔로워: 12,340명  |  | 좋아요: 3,210명   |  | [연결하기 →]       |  |
|  | 상품 동기화: ✅    |  | 카탈로그: ✅      |  |                   |  |
|  | [관리] [해제]      |  | [관리] [해제]     |  |                   |  |
|  +-------------------+  +-------------------+  +-------------------+   |
|                                                                         |
|  +-------------------+  +-------------------+                          |
|  | [PT 아이콘]        |  | [YT 아이콘]        |                         |
|  | Pinterest         |  | YouTube           |                          |
|  | ○ 미연결          |  | ○ 미연결          |                          |
|  | [연결하기 →]       |  | [연결하기 →]       |                         |
|  +-------------------+  +-------------------+                          |
|                                                                         |
+=========================================================================+
|  빠른 액션                                                               |
|  [전체 카탈로그 동기화 실행]  [광고 성과 보기]  [쇼핑 태그 관리]          |
+=========================================================================+
```

### 2.2 채널 연결 플로우

#### Instagram 연결 플로우

```
Step 1: 연결 시작
   [Instagram 연결하기] 클릭
         ↓
Step 2: Meta Business Manager 인증
   Instagram OAuth → 권한 선택
   필요 권한:
   - instagram_basic (프로필 읽기)
   - instagram_content_publish (쇼핑 태그 게시)
   - catalog_management (카탈로그 관리)
   - ads_read (광고 성과 읽기)
         ↓
Step 3: 비즈니스 계정 확인
   개인 계정 → 비즈니스/크리에이터 계정 전환 안내
         ↓
Step 4: 카탈로그 연동 설정
   기존 Meta 카탈로그 있음 → 연결 선택
   기존 카탈로그 없음 → 누리메이트가 자동 생성
         ↓
Step 5: 초기 동기화 실행
   전체 상품 카탈로그 Meta Commerce Manager로 전송
   소요시간: 상품 100개 기준 약 5분
         ↓
Step 6: 완료
   "Instagram 쇼핑 카탈로그 연동 완료!" + 상태 표시
```

#### TikTok Shop 연결 플로우

```
Step 1: TikTok for Business 계정 필요 안내
Step 2: TikTok OAuth (TikTok for Business API)
Step 3: TikTok Shop 판매자 계정 선택 또는 신규 생성 안내
Step 4: 상품 카탈로그 동기화 설정
Step 5: TikTok 상품 정책 검토 안내 (일본 현지 정책 포함)
Step 6: 완료
```

### 2.3 채널별 연결 상태 알림

| 상태 | 표시 방법 | 운영자 알림 |
|------|-----------|------------|
| 정상 연결 | 초록 점 + "연결됨" | 없음 |
| 토큰 만료 | 노란 점 + "재연결 필요" | 이메일 알림 |
| 동기화 오류 | 빨간 점 + "오류 확인" | 이메일 + 어드민 알림 |
| 정책 위반 (채널 측) | 빨간 점 + "계정 검토됨" | 이메일 + 어드민 알림 |

---

## 3. 상품 카탈로그 자동 동기화 기획

### 3.1 동기화 대상 데이터

| 필드 | 누리메이트 | Meta 카탈로그 | TikTok 카탈로그 |
|------|------------|--------------|----------------|
| 상품명 | product.name | title | product_name |
| 설명 | product.description | description | description |
| 가격 | product.price | price | price |
| 할인가 | product.sale_price | sale_price | sale_price |
| 이미지 | product.images[0] | image_link | image_url |
| 재고 | product.stock | availability | stock_quantity |
| SKU | product.sku | id | seller_sku |
| 카테고리 | product.category | google_product_category | category_id |
| 배송비 | product.shipping_fee | shipping | - |
| 브랜드 | store.brand | brand | brand |
| URL | product.url | link | product_url |

### 3.2 Meta Shopping 카탈로그 자동 연동

#### 동기화 방식

**방식 1: Batch Feed (배치 업로드)**
- 주기: 매일 새벽 3시 자동 실행
- 방식: 전체 상품 목록 JSON Feed 생성 → Meta Catalog Manager API 전송
- 장점: 안정적, 누락 없음
- 단점: 최대 24시간 지연 가능

**방식 2: Realtime Event 연동 (추가 구현)**
- 트리거: 상품 등록/수정/삭제 이벤트 발생 시
- 방식: Meta Catalog Batch API 즉시 호출
- 적용 범위: 가격 변경, 재고 0 처리 (품절 처리 즉시 반영)

#### 동기화 로직 상세

```
상품 이벤트 발생
     ↓
이벤트 큐에 적재 (Redis)
     ↓
동기화 워커 처리 (5분마다 배치)
     ↓
Meta Catalog API 호출
│
├── 성공 → 동기화 완료 기록
│          last_synced_at 업데이트
│
└── 실패 → 재시도 3회
           재시도 모두 실패 → 셀러 알림 + 어드민 알림
```

#### 카탈로그 필드 매핑 예시

```json
// 누리메이트 상품 → Meta 카탈로그 변환
{
  "id": "NM-SKU-1234",
  "title": "시어서커 루즈핏 블라우스",
  "description": "트렌디한 루즈핏 블라우스...",
  "availability": "in stock",
  "condition": "new",
  "price": "29000 KRW",
  "sale_price": "29000 KRW",
  "link": "https://myfashion.nurymate.com/products/1234",
  "image_link": "https://cdn.nurymate.com/products/1234/main.webp",
  "brand": "MyFashion",
  "google_product_category": "1604",
  "additional_image_link": "https://cdn.nurymate.com/.../2.webp"
}
```

#### 일본 셀러 특화: 엔화 카탈로그

- 일본 판매 활성화 셀러는 Meta JP 카탈로그 별도 생성
- 가격: 엔화 (JPY) 자동 변환 (환율 API 연동, 1일 1회 갱신)
- 언어: 상품명/설명 일본어 버전 자동 동기화

### 3.3 TikTok Shop 카탈로그 연동

#### TikTok Shop API 구조

- **API**: TikTok Shop Seller API v2 (Affiliate Program 포함)
- **상품 등록 방식**: Product Listing API (`POST /product/202309/products`)
- **재고 업데이트**: SKU API (`PUT /product/202309/products/{product_id}/skus`)

#### TikTok 특화 고려사항

| 항목 | 내용 |
|------|------|
| 영상 연동 | 상품 URL을 숏폼 영상 하단 링크로 연결 |
| TikTok Affiliate | 인플루언서 제휴 판매 자동 설정 |
| 라이브 커머스 | 라이브 방송 중 상품 자동 노출 설정 |
| 일본 카테고리 | 일본 TikTok Shop 카테고리 코드 별도 매핑 |

### 3.4 가격·재고 변경 자동 반영 로직

#### 가격 변경 시

```
셀러가 어드민에서 가격 변경 저장
     ↓
가격 변경 이벤트 발생 (product.price.updated)
     ↓
연동된 모든 SNS 채널에 즉시 업데이트 요청
│
├── Meta Catalog API: sale_price 필드 업데이트
├── TikTok Shop API: price 필드 업데이트
└── (기타 연동 채널)
     ↓
업데이트 완료 확인 (webhook or polling)
     ↓
셀러 어드민에 "모든 채널 가격 업데이트 완료" 표시
```

#### 재고 소진 시

```
재고 수량 0 도달
     ↓
즉시 모든 SNS 채널에 "품절" 처리 요청
│
├── Meta: availability = "out of stock"
├── TikTok: stock_quantity = 0
└── Instagram Shopping: 상품 비활성화
     ↓
재고 복구 시: 자동으로 "in stock" 전환
```

---

## 4. 광고 성과 통합 대시보드

### 4.1 대시보드 개요

```
+=========================================================================+
|  SNS 광고 성과 통합                 기간: [이번 달 ▾] [2026-03-01~10]  |
+=========================================================================+
|  전체 채널 합계                                                          |
|  총 광고비     총 매출    ROAS    전환수    CPA                          |
|  ₩2,840,000  ₩18,400,000  6.48x  284건   ₩10,000                      |
+=========================================================================+
|  채널별 성과 비교                                                        |
|  채널         광고비     매출      ROAS    전환율  CPA                   |
|  Instagram   ₩1,200,000  ₩8,400,000  7.0x  3.2%  ₩8,450              |
|  Facebook    ₩840,000    ₩4,800,000  5.7x  2.8%  ₩11,200             |
|  TikTok      ₩800,000    ₩5,200,000  6.5x  4.1%  ₩9,800              |
+=========================================================================+
|  시계열 차트 (ROAS 추이)                                                 |
|   8│     /\    /\                                                       |
|   6│  /\/  \  /  ──                                                    |
|   4│/         \/                                                        |
|    └──────────────────────────── 날짜                                   |
|    [IG] [FB] [TK]                                                       |
+=========================================================================+
|  상위 성과 광고 (채널별 Top 3)                                           |
|  + Instagram: 봄 신상 컬렉션 광고   ROAS 9.2x  클릭 1,240건  전환 42건  |
|  + TikTok: 블라우스 스타일링 영상   ROAS 8.7x  클릭 3,200건  전환 68건  |
+=========================================================================+
```

### 4.2 데이터 수집 방식

| 채널 | API | 데이터 갱신 주기 |
|------|-----|----------------|
| Instagram Ads | Meta Marketing API (`/act_{id}/insights`) | 1시간 |
| Facebook Ads | Meta Marketing API (동일) | 1시간 |
| TikTok Ads | TikTok Ads API v1.3 (`/report/integrated/get/`) | 3시간 |
| Pinterest Ads | Pinterest API v5 (`/ad_accounts/{id}/reports`) | 3시간 |

### 4.3 전환 추적 설정

#### Meta Pixel 자동 설치

셀러 어드민에서 Facebook 연결 시:
1. Meta Pixel 자동 생성 (또는 기존 Pixel 연동)
2. 누리메이트 스토어 테마에 Pixel 코드 자동 삽입
3. 표준 이벤트 자동 트래킹:
   - `PageView`: 모든 페이지 방문
   - `ViewContent`: 상품 상세 페이지
   - `AddToCart`: 장바구니 담기
   - `InitiateCheckout`: 결제 시작
   - `Purchase`: 결제 완료 (value, currency 포함)

#### TikTok Pixel 자동 설치

동일한 방식으로 TikTok Pixel 자동 삽입 및 이벤트 트래킹.

---

## 5. 인스타그램 Shopping 태그 자동화

### 5.1 Instagram Shopping 태그란

인스타그램 게시물·스토리·릴스에 상품 태그를 추가하여, 사용자가 태그 클릭 시 자사몰 상품 페이지로 이동하도록 연결하는 기능.

### 5.2 셀러 어드민 내 쇼핑 태그 관리

```
+=========================================================================+
|  Instagram 쇼핑 태그 관리                                                |
+=========================================================================+
|  최근 Instagram 게시물 (연동된 계정)                                     |
|                                                                         |
|  +----------+  +----------+  +----------+  +----------+                |
|  | [이미지]  |  | [이미지]  |  | [이미지]  |  | [이미지]  |               |
|  | 블라우스  |  | 원피스    |  | 팬츠      |  | 신발      |               |
|  | ✅ 태그됨 |  | ⚠️ 미태그 |  | ✅ 태그됨 |  | ⚠️ 미태그 |               |
|  | [수정]    |  | [태그 추가]|  | [수정]    |  | [태그 추가]|               |
|  +----------+  +----------+  +----------+  +----------+                |
|                                                                         |
|  자동 태그 추천: ✅ 활성화됨                                             |
|  → AI가 게시물 이미지에서 상품을 인식해 자동으로 태그 추천              |
|  [자동 태그 설정]                                                        |
+=========================================================================+
```

### 5.3 AI 기반 자동 태그 추천

**동작 원리**:
1. Instagram Graph API로 셀러 계정의 최신 미디어 목록 수집
2. 각 게시물 이미지를 Vision AI로 분석 → 이미지 내 상품 인식
3. 인식된 상품과 누리메이트 등록 상품 매핑 (이미지 유사도 기반)
4. 신뢰도 80% 이상인 경우 자동 태그 추천 알림 발송
5. 셀러 승인 후 Instagram API로 상품 태그 삽입

**기술 스택**:
- 이미지 분석: Google Vision API or AWS Rekognition
- 상품 매핑: 벡터 유사도 검색 (이미지 임베딩)
- 태그 삽입: Instagram Graph API `POST /{ig-media-id}/product_tags`

---

## 6. 플랫폼별 API 연동 방식 및 개발 요구사항

### 6.1 Meta (Instagram/Facebook) API

| 항목 | 내용 |
|------|------|
| API 버전 | Meta Graph API v21.0 |
| 인증 | OAuth 2.0 (Long-lived User Token, 60일 만료) |
| 앱 타입 | Meta Business App (Business 검증 필요) |
| 카탈로그 API | `POST /catalogs`, `POST /catalogs/{id}/batch` |
| 광고 API | `GET /act_{id}/insights` |
| 쇼핑 태그 API | `POST /{ig-media-id}/product_tags` |
| Rate Limit | 200 calls/hour per ad account |
| 개발 공수 | 약 4주 (카탈로그 + 광고 API + 쇼핑 태그) |
| 특이사항 | Meta Business 검증 완료 필요 (1~2주 소요) |

### 6.2 TikTok Shop API

| 항목 | 내용 |
|------|------|
| API 버전 | TikTok Shop Seller API v202309 |
| 인증 | OAuth 2.0 + App Key/Secret |
| 앱 타입 | TikTok for Business Developer App |
| 상품 API | `POST /product/202309/products` |
| 재고 API | `PUT /product/202309/products/{id}/inventory` |
| 광고 API | TikTok Ads API v1.3 |
| Rate Limit | 100 req/sec per endpoint |
| 개발 공수 | 약 3주 (카탈로그 + 광고 API) |
| 특이사항 | 한국/일본 각 TikTok Shop 판매자 계정 별도 필요 |

### 6.3 백엔드 아키텍처

#### SNS 연동 서비스 구조

```
backend/domain/sns_integration/
├── model.py          # SnsChannel, SnsProduct, SnsAdAccount 모델
├── service.py        # 비즈니스 로직 (동기화, 토큰 관리)
├── repository.py     # DB 접근
├── connectors/
│   ├── meta.py       # Meta API 클라이언트
│   ├── tiktok.py     # TikTok API 클라이언트
│   └── base.py       # 공통 인터페이스
└── tasks/
    ├── catalog_sync.py   # 카탈로그 동기화 태스크
    └── insights_pull.py  # 광고 성과 수집 태스크
```

#### 데이터베이스 모델

```python
class SnsChannel(SQLModel, table=True):
    id: UUID
    store_id: UUID
    platform: str  # "meta", "tiktok", "pinterest"
    access_token: str  # 암호화 저장
    refresh_token: Optional[str]
    token_expires_at: datetime
    catalog_id: Optional[str]
    ad_account_id: Optional[str]
    status: str  # "connected", "error", "expired"
    created_at: datetime
    updated_at: datetime

class SnsProductSync(SQLModel, table=True):
    id: UUID
    channel_id: UUID
    product_id: UUID
    external_product_id: str
    last_synced_at: datetime
    sync_status: str  # "synced", "error", "pending"
    error_message: Optional[str]
```

### 6.4 보안 요구사항

- Access Token: AES-256 암호화 후 DB 저장
- 토큰 갱신: 만료 7일 전 자동 갱신 스케줄러
- 토큰 갱신 실패 시: 셀러에게 재연결 요청 알림

---

## 7. 단계별 구현 로드맵

### 7.1 MVP (2026년 4월~6월, 런치 전)

| 기능 | 내용 | 예상 공수 |
|------|------|---------|
| Meta OAuth 연동 | Instagram/Facebook 계정 연결 | 1주 |
| Meta 카탈로그 동기화 | 상품 카탈로그 배치 동기화 (1일 1회) | 2주 |
| TikTok OAuth 연동 | TikTok for Business 계정 연결 | 1주 |
| TikTok 카탈로그 동기화 | 상품 카탈로그 배치 동기화 | 1.5주 |
| SNS 연동 허브 UI | 채널 목록, 연결 상태 표시 | 1주 |
| Meta Pixel 자동 설치 | 스토어에 Pixel 자동 삽입 | 0.5주 |
| **MVP 합계** | | **약 7주** |

### 7.2 성장 단계 (2026년 7월~9월)

| 기능 | 내용 |
|------|------|
| 실시간 가격·재고 동기화 | 이벤트 기반 즉시 반영 |
| 광고 성과 통합 대시보드 | Meta + TikTok 광고 성과 집계 |
| Instagram Shopping 태그 | 수동 태그 추가 UI |
| TikTok Pixel 자동 설치 | TikTok 전환 추적 |

### 7.3 고도화 단계 (2026년 10월~12월)

| 기능 | 내용 |
|------|------|
| AI 쇼핑 태그 자동 추천 | 이미지 인식 기반 자동 태그 |
| Pinterest 연동 | 카탈로그 + 광고 API |
| YouTube Shopping 연동 | 영상 상품 태그 |
| 통합 광고 관리 (누리메이트 내) | 광고 소재 생성·발행·최적화 |
| LINE 쇼핑 (일본) | 일본 LINE Shopping 연동 |

---

## 8. 경쟁사 대비 차별화 포인트

### 8.1 Shopify와의 비교

| 기능 | Shopify | 누리메이트 |
|------|---------|-----------|
| Meta 카탈로그 동기화 | ✅ (앱 설치 필요) | ✅ (기본 내장) |
| TikTok Shop 연동 | ✅ (앱 설치 필요) | ✅ (기본 내장) |
| 한국 결제 연동 | ❌ (별도 플러그인) | ✅ (네이티브 지원) |
| 일본어 자동 번역 카탈로그 | ❌ | ✅ |
| 광고 성과 통합 대시보드 | 일부 (앱 필요) | ✅ (기본 내장) |
| 앱 스토어 추가 비용 | $10~50/월 | 없음 (내장) |

### 8.2 카페24와의 비교

| 기능 | 카페24 | 누리메이트 |
|------|--------|-----------|
| Meta 카탈로그 동기화 | ✅ (파트너 앱) | ✅ (기본 내장) |
| TikTok Shop 연동 | 제한적 | ✅ |
| 일본 TikTok Shop | ❌ | ✅ |
| AI 쇼핑 태그 추천 | ❌ | ✅ (고도화 단계) |
| 글로벌 광고 성과 통합 | 제한적 | ✅ |

### 8.3 누리메이트만의 차별화 포인트

1. **기본 내장**: 별도 앱 설치·비용 없이 모든 SNS 연동 기능 기본 제공
2. **한국·일본 동시 최적화**: 카탈로그를 한국어/일본어로 동시에 운영, 통화도 원화/엔화 자동 분리
3. **AI 자동화**: 게시물 이미지 분석으로 쇼핑 태그 자동 추천 (로드맵)
4. **통합 분석**: 모든 SNS 채널 광고 성과를 하나의 대시보드에서 비교
5. **D2C 전략 특화**: SNS에서 자사몰로의 이탈 없는 전환 여정 설계

---

## 9. 리스크 및 대응 방안

| 리스크 | 영향도 | 대응 방안 |
|--------|--------|---------|
| Meta API 정책 변경 | 높음 | API 버전 고정 + 모니터링 알림, 빠른 대응 체계 |
| TikTok Shop 일본 진출 지연 | 중간 | Pinterest JP 대안 조기 개발 |
| 카탈로그 동기화 오류로 가격 불일치 | 높음 | 동기화 검증 로직, 오류 즉시 알림, 셀러 직접 확인 버튼 |
| Meta Business 검증 지연 | 중간 | 검증 신청 MVP 개발 시작 전 선행 진행 |
| 토큰 만료로 인한 동기화 중단 | 중간 | 만료 7일 전 자동 갱신 + 셀러 알림 |

---

---

## 10. 인스타그램 데이터 연동 분석

> **배경**: AI 인사이트가 "금요일 인스타그램 포스팅 이후 트래픽이 집중됐다"는 분석을 제공하려면 인스타그램 포스팅 시각·도달수 등의 데이터를 누리메이트 트래픽/매출 데이터와 연결해야 한다. 이 섹션은 해당 연동의 데이터 범위, 인증 방식, 분석 로직, 미연동 대응을 정리한다.

### 10.1 Instagram Graph API 데이터 범위

#### 조회 가능한 미디어 인사이트 필드

| 필드명 | 설명 | 비즈니스 계정 | 크리에이터 계정 |
|--------|------|:------------:|:--------------:|
| `timestamp` | 포스팅 게시 시각 (ISO 8601) | ✅ | ✅ |
| `reach` | 도달 수 (고유 계정 기준) | ✅ | ✅ |
| `impressions` | 노출 수 (중복 포함) | ✅ | ✅ |
| `saved` | 저장 수 | ✅ | ✅ |
| `link_clicks` | 프로필 링크·쇼핑 태그 클릭 수 | ✅ | ⚠️ 제한적 |
| `profile_visits` | 프로필 방문 수 | ✅ | ✅ |
| `follows` | 해당 게시물 경유 팔로우 수 | ✅ | ✅ |
| `video_views` | 릴스·동영상 조회 수 | ✅ | ✅ |
| `total_interactions` | 좋아요+댓글+공유+저장 합계 | ✅ (v18.0+) | ✅ (v18.0+) |

> **API 버전 주의**: `total_interactions` 필드는 Graph API v18.0(2023년 9월) 이후 추가됨. v17.0 이하를 사용할 경우 개별 필드를 합산해야 함. 현재 연동 대상 버전: **v21.0** (섹션 6.1 기준).

#### 계정 유형별 접근 제한

| 항목 | 비즈니스 계정 | 크리에이터 계정 | 개인 계정 |
|------|:------------:|:--------------:|:---------:|
| 미디어 인사이트 API | ✅ | ✅ | ❌ |
| `link_clicks` 상세 | ✅ (쇼핑 태그 포함) | 프로필 링크만 | ❌ |
| 광고 인사이트 (Ads API) | ✅ | ❌ | ❌ |
| 스토리 인사이트 | ✅ | ✅ | ❌ |
| 계정 수준 인사이트 | ✅ | ✅ | ❌ |

- **개인 계정 셀러**: 비즈니스 또는 크리에이터 계정으로 전환 필수. 전환 유도 UX를 연동 플로우에 포함 (섹션 10.2 참고).
- **link_clicks의 의미 차이**: 비즈니스 계정은 쇼핑 태그 클릭·외부 링크 클릭·프로필 링크 클릭을 구분 조회 가능. 크리에이터 계정은 프로필 링크 클릭만 제공.

#### 데이터 보존 기간 제한

- 인사이트 데이터: **최대 2년** 소급 조회 가능 (Meta 정책)
- 미디어 리스트 (`GET /{ig-user-id}/media`): 전체 기간 조회 가능 (타임스탬프 포함)
- **권장 전략**: 연동 즉시 과거 90일치 인사이트를 백필(backfill)하고, 이후 매일 증분 수집.

---

### 10.2 OAuth 연동 플로우

#### 전체 인증 흐름

```
[셀러 어드민] "인스타그램 인사이트 연동" 클릭
      ↓
[누리메이트 백엔드] Meta OAuth 2.0 인증 URL 생성
      scope: instagram_basic, instagram_manage_insights,
             pages_read_engagement, pages_show_list
      ↓
[Facebook 로그인 팝업] 셀러 계정 로그인
      ↓
[권한 동의 화면] 요청 권한 목록 표시 → 셀러 승인
      ↓
[Facebook] Authorization Code → 누리메이트 redirect_uri 전달
      ↓
[누리메이트 백엔드] Authorization Code → Short-lived User Token 교환
      (POST https://graph.facebook.com/oauth/access_token)
      ↓
[누리메이트 백엔드] Short-lived → Long-lived User Token 교환 (60일)
      (GET /oauth/access_token?grant_type=fb_exchange_token)
      ↓
[누리메이트 백엔드] Long-lived User Token → Page Access Token 교환
      (GET /{page-id}?fields=access_token)
      ↓
[누리메이트 백엔드] Page Access Token으로 연결된 Instagram Business Account ID 조회
      (GET /{page-id}?fields=instagram_business_account)
      ↓
[DB 저장] ig_user_id, long_lived_token, token_expires_at (60일 후)
      ↓
[완료] 인사이트 수집 초기화 (과거 90일 백필)
```

#### 필요 권한(Scope) 목록

| Scope | 용도 | 필수 여부 |
|-------|------|:--------:|
| `instagram_basic` | 미디어 목록·프로필 조회 | 필수 |
| `instagram_manage_insights` | 미디어·계정 인사이트 조회 | 필수 |
| `pages_read_engagement` | Facebook 페이지 인게이지먼트 읽기 | 필수 (IG 비즈니스 계정 연결용) |
| `pages_show_list` | 셀러 소유 페이지 목록 조회 | 필수 (올바른 페이지 선택용) |
| `instagram_content_publish` | 쇼핑 태그 게시 (섹션 5 기능) | 선택 (인사이트 전용이면 불필요) |
| `catalog_management` | 카탈로그 관리 (섹션 3 기능) | 선택 |

> **최소 권한 원칙**: 인사이트 연동만이 목적인 셀러에게는 `instagram_basic` + `instagram_manage_insights` + `pages_read_engagement` + `pages_show_list` 4개만 요청. 범위를 최소화해 셀러의 권한 거부율을 낮춘다.

#### 토큰 갱신 처리

| 토큰 유형 | 만료 기간 | 갱신 방법 |
|-----------|----------|----------|
| Short-lived User Token | 1~2시간 | Long-lived로 즉시 교환 |
| Long-lived User Token | 60일 | 만료 7일 전 `GET /oauth/access_token?grant_type=fb_exchange_token` 자동 호출 |
| Page Access Token | Long-lived 기반 → 무기한 | Long-lived 갱신 시 자동 유효 유지 |

- **갱신 실패 시**: 셀러에게 이메일 알림 발송 + 어드민 알림 노출 (섹션 2.3 기존 로직 재사용)
- **갱신 성공 기준**: HTTP 200 + 새 토큰 수령 → DB `token_expires_at` 업데이트

#### 비즈니스/크리에이터 계정 전환 유도 UX

```
개인 계정 감지 시:

+============================================================+
|  ⚠️  인스타그램 비즈니스 계정이 필요합니다                  |
+============================================================+
|  현재 계정(@myfashion_kr)은 개인 계정입니다.               |
|  인사이트 데이터 조회를 위해 비즈니스 또는                   |
|  크리에이터 계정으로 전환해야 합니다.                        |
|                                                            |
|  전환 방법: Instagram 앱 → 설정 → 계정 → 계정 유형 전환     |
|                                                            |
|  [전환 방법 자세히 보기 ↗]  [전환 완료, 다시 시도]          |
+============================================================+
```

---

### 10.3 AI 인사이트 — 인스타그램 × 트래픽 상관관계 로직

#### 데이터 수집 아키텍처

```
[Instagram Graph API]           [누리메이트 내부 데이터]
  - 포스팅 timestamp               - 스토어 페이지뷰 (시간대별)
  - reach, impressions             - 상품 상세 조회수 (시간대별)
  - link_clicks                    - 장바구니 담기 이벤트
  - saves                          - 결제 완료 (매출)
        ↓                                    ↓
        +-----------[데이터 웨어하우스 통합]----------+
        |    ig_posts 테이블 + store_traffic 테이블    |
        +----------------------------------------------+
                          ↓
              [인사이트 분석 엔진 (Python)]
                          ↓
              [AI 인사이트 생성 → 셀러 대시보드]
```

#### 상관관계 계산 방법

**Step 1: 포스팅 이벤트 윈도우 정의**

각 인스타그램 포스팅을 기준으로 **전후 시간 윈도우**를 설정하여 트래픽 변화를 측정한다.

```
포스팅 시각 (T)
  |
  |← 기준선 윈도우 (T-48h ~ T) ─→|← 효과 윈도우 (T ~ T+48h) →|
```

- **기준선(Baseline)**: 포스팅 전 48시간 평균 트래픽
- **효과 윈도우**: 포스팅 후 48시간 트래픽 (6시간 단위 집계)
- **트래픽 증가율**: `(효과 윈도우 평균 - 기준선) / 기준선 × 100%`

**Step 2: 요일·시간대 패턴 분석**

누적 포스팅 이력(최소 8회 이상)이 쌓이면 요일별·시간대별 효과를 집계한다.

```python
# 의사 코드
for post in ig_posts:
    baseline = avg_traffic(T - 48h, T)
    effect = avg_traffic(T, T + 48h)
    uplift_pct = (effect - baseline) / baseline * 100

# 요일별 평균 uplift 계산
weekday_avg = group_by(posts, "weekday").mean("uplift_pct")
# → {"금요일": 38.2%, "토요일": 22.1%, "수요일": 11.5%, ...}

# 최고 성과 요일 + 시간대 도출
best_slot = weekday_avg.idxmax()  # "금요일"
```

**Step 3: 매출 기여도 추정**

- **어트리뷰션 방식**: 포스팅 후 48시간 내 발생한 `utm_source=instagram` 세션의 매출을 직접 기여로 집계
- UTM 없는 경우: 포스팅 후 트래픽 급증 시점과 매출 급증 시점의 지연 시간(lag) 상관관계로 간접 추정

**Step 4: 인사이트 문장 생성**

```
조건: 금요일 포스팅 uplift ≥ 30%, 최소 4회 반복 확인 시

→ 생성 인사이트:
  "지난 8주 분석 결과, 금요일 오후 6~9시에 포스팅하면
   평균 38% 트래픽 증가 효과가 있었어요.
   다음 주 금요일 오후 7시 포스팅을 추천합니다. 📊"
```

#### 통계적 유의성 판단 기준

| 조건 | 기준값 | 설명 |
|------|--------|------|
| 최소 샘플 수 | 포스팅 8회 이상 | 패턴 도출 신뢰 최소치 |
| 반복성 | 동일 요일 최소 3회 동일 방향 | 우연이 아닌 패턴으로 판단 |
| 효과 크기 임계값 | uplift ≥ 15% | 노이즈 수준 이상의 실질 효과 |
| 이상치 제거 | uplift > 500% 제외 | 이벤트·광고 집행 구간 배제 |

> **주의**: 샘플이 부족하거나 통계 기준 미충족 시 인사이트를 생성하지 않고 "아직 데이터가 부족해요. 8회 이상 포스팅 후 분석 결과를 드릴게요."로 대체 메시지를 표시한다.

#### 데이터 수집 스케줄

| 수집 항목 | 주기 | API 엔드포인트 |
|----------|------|--------------|
| 미디어 목록 (신규 포스팅 감지) | 매 1시간 | `GET /{ig-user-id}/media` |
| 개별 포스팅 인사이트 | 포스팅 후 1h·6h·24h·48h | `GET /{ig-media-id}/insights` |
| 계정 수준 인사이트 | 매일 새벽 2시 | `GET /{ig-user-id}/insights` |

---

### 10.4 미연동 셀러 대체 인사이트

인스타그램 연동을 하지 않은 셀러에게도 트래픽 출처 분석이 가능하도록 UTM 기반 대체 인사이트를 제공한다.

#### UTM 파라미터 기반 트래픽 출처 분석

**셀러가 직접 UTM 링크를 만들어 인스타그램 바이오·게시물에 삽입하는 방식.**

```
누리메이트 스토어 URL + UTM 파라미터
예: https://myfashion.nurymate.com
    ?utm_source=instagram
    &utm_medium=bio_link
    &utm_campaign=spring2026
    &utm_content=friday_post
```

**누리메이트 어드민 내 UTM 링크 생성기 제공**:

```
+============================================================+
|  UTM 링크 생성기                                            |
+============================================================+
|  출처(source): [instagram        ]                         |
|  매체(medium): [bio_link         ]                         |
|  캠페인명:     [spring2026       ]                         |
|  콘텐츠:       [friday_post      ]                         |
|                                                            |
|  생성된 링크:                                               |
|  https://myfashion.nurymate.com?utm_source=instagram&...  |
|  [복사]  [단축 URL 생성]                                    |
+============================================================+
```

#### UTM 기반 제공 가능한 인사이트

| 인사이트 항목 | 내용 | 인스타그램 연동 필요 여부 |
|-------------|------|:--------------------:|
| 채널별 방문자 수 | 인스타그램 vs. 직접 접속 vs. 네이버 | ❌ (UTM만으로 가능) |
| 캠페인별 전환율 | 게시물 유형별 구매 전환율 비교 | ❌ |
| 요일별 인스타그램 유입량 | 요일·시간대별 utm_source=instagram 트래픽 | ❌ |
| 포스팅별 성과 대비 | 어떤 포스팅이 더 많은 유입을 만들었는지 | ✅ (포스팅 시각 데이터 필요) |
| 도달 수 대비 전환율 | reach 대비 실제 구매 전환 효율 | ✅ |

#### 미연동 셀러 대상 인사이트 예시 문구

```
[연동 없이 제공 가능한 인사이트]
"이번 주 인스타그램을 통한 방문자가 전체의 42%를 차지했어요.
 지난주 대비 18% 증가했습니다."

"금요일에 인스타그램 유입이 가장 많았어요 (주간 비중 31%).
 인스타그램 계정을 연동하면 어떤 포스팅이 효과적인지 확인할 수 있어요. →"
```

> **연동 유도 CTA**: 미연동 인사이트 카드 하단에 항상 "인스타그램 연동하면 포스팅별 성과까지 분석해 드려요" 메시지를 노출하여 자연스럽게 연동을 유도한다.

#### 미연동 셀러를 위한 수동 포스팅 기록 기능 (검토 중)

셀러가 직접 "오늘 오후 6시에 인스타그램 포스팅했어요" 라고 누리메이트에 기록하면, UTM 트래픽 데이터와 결합하여 포스팅 효과를 분석하는 반자동 방식. API 연동 없이 동작하지만 셀러 입력 부담이 있어 UX 검토 후 구현 여부 결정.

---

*문서 버전: v0.1 | 다음 업데이트: API 연동 POC 완료 후 기술 스펙 보완 예정*
