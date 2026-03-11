# Shopify 마케팅·기여도 분석 기능 및 써드파티 앱 조사 [11-10]

> 조사일: 2026-03-10 | 목적: 누리메이트 마케팅 기능 내재화 전략 수립

---

## 1. Shopify 기본 제공 마케팅 기능

### 1-1. 마케팅 자동화

#### Shopify Email
- 플랜 제한 없이 기본 제공 (무료 이메일 10,000건/월, 이후 $1/1,000건)
- 드래그앤드롭 이메일 에디터, 상품 삽입 블록, 할인 코드 자동 생성
- 자동화 트리거: 장바구니 이탈, 가입 환영, 첫 구매 감사, 재구매 유도 등
- 멀티스텝 자동화 플로우(Flow 연동) 지원

#### Shopify Flow
- 시각적 워크플로우 빌더 (If-Then 로직)
- Shopify 이벤트 트리거: 주문 생성, 결제 완료, 태그 추가, 고객 등급 변경 등
- 자동 태그 부여, 이메일 발송, 외부 앱(Slack, 3PL 등) 연동 액션
- **Basic/Grow: 기본 템플릿 한정 / Advanced·Plus: 커스텀 플로우 무제한**

#### Shopify Messaging (Email + SMS)
- SMS 마케팅은 파트너 앱(Klaviyo, Postscript 등)과 연동 방식
- 기본 제공 SMS 자동화: 주문 확인, 배송 알림 등

### 1-2. 고객 세그먼트 및 타겟팅

- **동적 세그먼트**: 조건 기반 자동 업데이트 세그먼트
  - 조건 예시: 주문 횟수 ≥ 3, 최근 구매일 ≤ 30일, 특정 제품 구매자, LTV 상위 10%
  - 고객 행동(상품 조회, 구매, 태그, 이메일 클릭)에 따라 자동 추가/제거
- **사전 정의 세그먼트**: 신규 고객, 재구매 고객, 이탈 위험 고객, 고가치 고객 등
- 세그먼트를 Shopify Email, Flow, Meta Ads, Google Ads 광고 타겟으로 직접 연동

### 1-3. 기여도 분석 (Attribution)

#### 기본 기여도 모델
- 채널별 세션·전환 트래킹: Organic, Direct, Email, Paid Search, Social, Referral
- 기본 어트리뷰션 모델: **라스트 클릭(Last Click)** 방식 (기본값)
- 멀티터치 어트리뷰션 보고서: Shopify Analytics에 기본 포함 (Advanced 이상)

#### 멀티터치 어트리뷰션 (Advanced/Plus)
- 채널별 전환 기여도를 가중 분산하여 표시
- 이메일·SMS 마케팅 전환 기여도 추적
- 단, **교차 플랫폼 어트리뷰션(Meta·Google·Kakao 동시 분석)은 Shopify 단독으로 불완전** → 써드파티 필요

#### Shopify Audiences (Plus 전용)
- Shopify 전체 네트워크 구매 데이터 활용, Meta·Google 광고용 최적화 타겟 리스트 자동 생성
- 유사 고객(Lookalike Audience) 고도화 지원
- ROAS 향상 효과 보고 사례 다수 (일부 브랜드 30~50% ROAS 개선 보고)

---

## 2. 인기 써드파티 앱 조사 (Shopify App Store 마케팅 카테고리)

### 2-1. 마케팅 자동화 앱

#### Klaviyo (이메일·SMS·WhatsApp)
- **Shopify App Store 마케팅 카테고리 1위** (리뷰 수 3,800+, 평점 4.6/5)
- 핵심 기능: 이커머스 특화 행동 트리거 자동화, 예측 분석(다음 구매일 예측), A/B 테스트, RFM 세그먼트
- 요금: 무료(250연락처까지), 이후 연락처 수 기준 과금 (500명 $20/월 ~ 10만명 $700+/월)
- 특징: Shopify 데이터와 깊이 통합, 고급 분석, 단 가격이 비쌈

#### Omnisend (이메일·SMS·푸시 알림)
- 리뷰 수 5,700+, 평점 4.8/5 (Shopify App Store 기준 평점 Klaviyo보다 높음)
- 핵심 기능: 멀티채널 자동화(이메일+SMS+푸시 통합 플로우), 팝업·스핀 휠, 캠페인 부스터
- 요금: 무료(500이메일/월), Klaviyo 대비 저렴 ($16/월~)
- 특징: 비기술 사용자도 쉬운 UX, Klaviyo보다 인터페이스 친화적

#### Privy (팝업·이메일·SMS)
- 리뷰 수 25,000+, 평점 4.6/5 (Shopify App Store 내 매우 높은 리뷰 수)
- 핵심 기능: 이메일 리스트 수집 팝업(Exit Intent, Flyout, Spin-to-Win), 기본 이메일 자동화
- 요금: 무료(소규모), $30/월~
- 특징: 리스트 빌딩에 특화, 이메일 마케팅 플랫폼으로 진화 중

### 2-2. 기여도·전환 분석 앱

#### Triple Whale
- Shopify App Store 평점 4.7/5, 리뷰 수 500+
- 핵심 기능: 멀티채널 통합 대시보드(Meta+Google+TikTok+Klaviyo+Shopify), 픽셀 기반 퍼스트파티 데이터 수집, 멀티터치 어트리뷰션(MTA), 마케팅 믹스 모델링(MMM), 증분성 테스트
- AI 기능: "Moby AI" — 자연어로 데이터 질문 → 즉시 답변
- 요금: $129/월~, 매출 규모별 과금
- 특징: 2025년 기준 Shopify 생태계 내 어트리뷰션 표준 툴로 자리매김, 175+ 브랜드 사용

#### Northbeam
- 핵심 기능: MTA + MMM 병행, 예측 어트리뷰션, SKU 단위 마진 추적
- 요금: $99/월~ (매출 기반 스케일)
- 특징: 대형 DTC 브랜드 타겟, 데이터 과학팀이 있는 기업에 적합

#### Rockerbox
- 핵심 기능: 통합 마케팅 어트리뷰션, TV·OOH 오프라인 채널 포함 측정, 커스텀 어트리뷰션 모델
- 요금: 엔터프라이즈 가격, 협의
- 특징: 오프라인 채널까지 통합 측정하는 드문 툴

#### Elevar (GA4 + 서버사이드 트래킹)
- 핵심 기능: 서버사이드 이벤트 트래킹, GA4·Meta·Google Ads 데이터 정확도 향상
- 요금: $50/월~
- 특징: iOS 14+ 이후 쿠키 차단 환경에서 데이터 손실 방지에 특화

### 2-3. 리뷰·UGC 앱

#### Judge.me
- Shopify App Store 평점 5.0/5, 리뷰 수 34,000+ (최다 리뷰 앱 중 하나)
- 핵심 기능: 자동 리뷰 요청 이메일, 사진·비디오 리뷰, Google Shopping 스니펫 연동
- 요금: 무료 플랜 있음, $15/월 (Pro)
- 특징: 가성비 최고, 소규모 스토어에 최적

#### Yotpo (리뷰·로열티·SMS)
- 평점 4.8/5, 리뷰 수 7,000+
- 핵심 기능: 리뷰+로열티 프로그램+SMS 통합 플랫폼, UGC(사진·비디오), 구글·메타 리뷰 신디케이션
- 요금: 무료 플랜 있음, $79/월 Growth~
- 특징: 올인원 고객 마케팅 플랫폼, 중대형 브랜드 선호

### 2-4. 리타겟팅·광고 연동 앱

#### AdRoll (리타겟팅·디스플레이 광고)
- 핵심 기능: 웹·이메일·소셜 통합 리타겟팅, 동적 광고 자동화
- 요금: 광고 집행 기반 성과 수수료, 기본 $36/월~
- 특징: 소중형 브랜드 맞춤형 리타겟팅 솔루션

#### Meta·Google 광고 공식 연동
- **Facebook & Instagram (Meta)**: Shopify 기본 내장, 카탈로그 자동 동기화, 픽셀 자동 설치
- **Google & YouTube**: Shopify 기본 내장, Google 쇼핑 피드 자동 동기화, 전환 트래킹
- 공식 채널 앱이므로 별도 비용 없이 기본 기능 사용 가능

---

## 3. 앱별 핵심 정보 요약

| 앱 | 카테고리 | 주요 기능 | 평점 | 리뷰 수 | 시작 요금 |
|----|---------|---------|------|--------|---------|
| Klaviyo | 이메일·SMS | 고급 자동화, 예측분석 | 4.6 | 3,800+ | 무료 ~ $20+/월 |
| Omnisend | 이메일·SMS·푸시 | 멀티채널 자동화 | 4.8 | 5,700+ | 무료 ~ $16+/월 |
| Privy | 팝업·이메일 | 리스트 빌딩 | 4.6 | 25,000+ | 무료 ~ $30+/월 |
| Triple Whale | 어트리뷰션 | 통합 대시보드, MMM | 4.7 | 500+ | $129+/월 |
| Northbeam | 어트리뷰션 | MTA+MMM 심층 분석 | 4.5 | 100+ | $99+/월 |
| Judge.me | 리뷰·UGC | 리뷰 수집, 구글 연동 | 5.0 | 34,000+ | 무료 ~ $15/월 |
| Yotpo | 리뷰·로열티·SMS | 올인원 CRM | 4.8 | 7,000+ | 무료 ~ $79+/월 |
| AdRoll | 리타겟팅 | 멀티채널 광고 | 4.3 | 2,000+ | $36+/월 |

---

## 4. 누리메이트 자체 내재화 시 우선순위 판단

### 4-1. 높은 우선순위: 직접 내재화 권장 기능

#### 이메일 마케팅 자동화 기본 기능
- 이유: 이커머스 운영자 필수 기능, 외부 앱 비용($20~700+/월) 절감 효과로 플랫폼 Lock-in 강화
- 내재화 범위: 장바구니 이탈 복구, 가입 환영, 주문 확인, 재구매 유도 (5~10개 기본 플로우)
- 인사이트: Omnisend 스타일(쉬운 UI)이 Klaviyo 스타일(복잡한 기능)보다 누리메이트 타겟에 적합

#### 고객 세그먼트 기반 타겟팅
- 이유: RFM 세그먼트 + 동적 필터는 재구매율 향상의 핵심, 타 플랫폼 대비 차별화 포인트
- 내재화 범위: RFM 기반 자동 세그먼트(3~5개 사전 정의), 커스텀 조건 필터

#### 리뷰 수집 및 사회적 증거
- 이유: Judge.me 수준(무료~$15)의 기본 리뷰 수집 기능은 직접 내재화해도 개발 비용 합리적
- 내재화 범위: 자동 리뷰 요청 이메일, 별점+텍스트+이미지 리뷰, 상품 상세 페이지 위젯

### 4-2. 중간 우선순위: 파트너십 또는 단계적 내재화

#### 멀티채널 어트리뷰션 (Triple Whale 류)
- 이유: 국내 채널(카카오, 네이버, 쿠팡) 포함 통합 어트리뷰션 제공 시 강력한 차별화
- 방향: 초기 단계는 국내 광고 채널 API 연동 수준으로 시작, 중기에 자체 어트리뷰션 모델 개발
- 시장 강점: Triple Whale 등 글로벌 툴은 한국 채널(카카오 광고, 네이버 광고) 데이터 지원 미흡

#### 로열티 프로그램
- 이유: Yotpo·Smile.io 등 선호도 높은 기능, 재구매율 직결
- 방향: 기본 포인트 적립/사용 기능부터 내재화, 고급 기능은 파트너 앱 연동

### 4-3. 낮은 우선순위 또는 파트너 연동 유지

#### SMS 마케팅 (국내 특화 필요)
- 국내 SMS는 KISA 규정(광고 문자 수신 동의 등) 복잡, 국내 SMS 게이트웨이 별도 연동 필요
- 초기에는 Solapi, Coolsms 등 국내 SMS API와 연동 방식으로 제공

#### 고급 MMM (마케팅 믹스 모델링)
- 데이터 과학 역량 요구, 소규모 사업자 실질 활용도 낮음
- 중장기 Plus 등급 사용자 대상 기능으로 고려

---

*Sources:*
- [Shopify Marketing Automation Tools](https://www.shopify.com/marketing-automation-tools)
- [Klaviyo App Store Listing](https://apps.shopify.com/klaviyo-email-marketing)
- [Triple Whale Review 2025 - Ecommerce Fastlane](https://ecommercefastlane.com/triple-whale-review/)
- [Shopify Analytics Showdown - Conspire Agency](https://www.conspireagency.com/blogs/shopify/shopify-analytics-showdown-northbeam-vs-triple-whale-vs-elevar)
- [Best Shopify Email Marketing Apps 2025 - MercadoKit](https://mercadokit.com/guides/best-shopify-email-marketing-apps)
- [Top 10 Shopify Analytics Apps 2025 - ReportGenix](https://reportgenix.com/top-10-shopify-analytics-apps/)
