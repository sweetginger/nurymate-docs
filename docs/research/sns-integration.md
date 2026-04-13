# SNS 마케팅 연동 플랫폼별 제휴 조건 조사 [6-8]

> 조사일: 2026-03-10 | 목적: 셀메이트CM SNS 마케팅 연동 기능 설계

---

## 1. 플랫폼별 비즈니스 API·파트너 프로그램 개요

### 1-1. Meta (Facebook·Instagram)

**공식 API**
- Marketing API: 광고 캠페인 생성·관리·리포팅의 핵심 API
- Instagram Graph API: 비즈니스 계정의 게시물 관리, 해시태그 탐색, 멘션 수집
- Catalog API: 상품 카탈로그 연동 (Facebook Shop, Instagram Shopping)
- Conversions API (CAPI): 서버 측 픽셀·이벤트 추적 (쿠키리스 환경 대응)
- WhatsApp Business API: 메시지 발송 (한국 시장보다 글로벌/일본 활용도 높음)

**Meta Business Partner 프로그램**

| 등급 | 조건 | 혜택 |
|------|------|------|
| **Member** | 최소 광고비 $5,000 달성, Meta Blueprint 인증 1명 | 파트너 디렉터리 미등재, 기본 리소스 접근 |
| **Badged Partner** | 일정 수준 이상 광고비 집행 실적, Blueprint 인증, 비즈니스 성장 증빙, 기술 역량 심사 | 파트너 배지, 라이브 채팅 지원, 기술 지원, 독점 교육 프로그램 |
| **에이전시 퍼스트 (한국)** | Meta가 직접 선정 (2025년 33개사). Premium/Preferred/Member 3단계 | 최신 광고 솔루션 교육, Meta 전문가 배정, 마케팅 자료 제공 |

**API 비용 및 Rate Limit**
- Marketing API 자체는 무료 (광고비 집행이 비용)
- Rate Limit: 점수 기반 시스템
  - Read 호출: 1점 / Write 호출: 3점
  - 개발 계정: 최대 60점, 초과 시 300초 차단
  - 표준 계정: 최대 9,000점, 초과 시 60초 차단
- Mutation 제한: 100 QPS (초당 쓰기 작업 100건)
- Instagram Graph API: 시간당 200 요청/계정

---

### 1-2. TikTok

**공식 API**
- TikTok for Business API (Marketing API): 광고 캠페인 생성·관리
- TikTok Catalog API: 상품 카탈로그 연동 (TikTok Shop)
- Content Posting API:
  - Direct Post: 승인된 계정으로 직접 게시
  - Upload (Draft): 임시저장 후 TikTok 앱에서 최종 게시
- TikTok Pixel & Events API: 웹 전환 추적
- TikTok Shop for Shopify: Shopify 연동 플러그인 공식 제공

**파트너 프로그램**
- 개발자 등록: 이메일 인증 → 앱 등록 → TikTok 팀 심사 승인
- 심사 조건: 앱/서비스 데모 계정 무상 제공 필수, 이용약관 준수 서약, 통합 가이드라인 준수
- 위반 시: 즉각 연동 취소 및 향후 통합 영구 금지
- 공식 파트너(Technology Partner): TikTok for Business 사이트에서 인증 파트너 배지 취득 가능

**API 비용 및 Rate Limit**
- 기본 API 사용 무료 (광고 운영 비용 별도)
- Rate Limit: 플랜별 상이, 공식 포털(business-api.tiktok.com)에서 확인 필요
- TikTok Shop 연동: 커머스 파트너 별도 심사

---

### 1-3. X (Twitter)

**공식 API**
- X Ads API: 광고 캠페인 관리
- X Basic API (v2): 트윗 검색, 게시, 멘션 모니터링
- Enterprise API: 전체 데이터 스트림 접근

**파트너 프로그램**
- X Developer Portal 가입 → 앱 등록 → 사용 목적 명시
- 광고 관련: X Ads API 파트너 신청 필요 (별도 심사)
- 2023년 이후 API 유료화로 정책 변경:
  - Free 플랜: 읽기 1,500 트윗/월, 게시 500건/월
  - Basic ($100/월): 읽기 10,000건, 게시 3,000건
  - Pro ($5,000/월): 읽기 1,000,000건, 게시 300,000건
  - Enterprise: 별도 협상

**커머스 연동 제한**: X는 Meta·TikTok 대비 커머스 카탈로그 연동 기능 미흡. 셀메이트CM 연동 우선순위 낮음

---

### 1-4. LINE (일본)

**공식 API**
- LINE Messaging API: 공식 LINE 계정에서 메시지 발송, 리치 메뉴 구성
- LINE Login API: 소셜 로그인
- LINE Pay API: 결제 연동
- LINE Ads API: 광고 캠페인 관리

**파트너 프로그램 (LINEヤフー Partner Program)**
- Technology Partner 인증: 기술 지원 역량, LINE 사양 대응 능력, 사양 공유 의향 등 평가
- 최고 등급: "Premier Technology Partner" — 조건 충족 시 배지 취득
- 인증 현황: 2025년도 신규 인증 파트너사 발표 완료 (자치체 통신 Online 보도)
- LINE MINI App Platform: 일본 특화 앱 내 서비스. 2025년 11월 약관 개정됨

**일본 마케팅에서의 중요도**
- 일본 월간 활성 사용자 9,700만+ (2025 기준). 한국의 카카오톡과 유사한 국민 메신저
- 기업 LINE 공식 계정 메시지 발송이 이메일 대비 높은 오픈율 기록
- 카탈로그 연동: LINE 스마트채널 광고를 통한 상품 노출 가능

---

### 1-5. YouTube

**공식 API**
- YouTube Data API v3: 영상 검색, 채널 정보, 댓글 수집
- YouTube Ads (Google Ads API): 유튜브 광고 캠페인 관리
- YouTube Shopping: 상품 카드 연동 (Google Merchant Center 연동)

**파트너 프로그램**
- Google Partners 프로그램: YouTube 광고 포함
- Google Marketing Platform Partner: 대규모 광고주/에이전시 대상
- YouTube BrandConnect: 크리에이터-브랜드 공식 매칭 플랫폼

**커머스 연동**
- Google Merchant Center를 통한 상품 피드 등록 → YouTube Shopping 연동
- 쇼피파이·카페24 모두 Google Merchant Center 공식 연동 지원

---

### 1-6. Pinterest

**공식 API**
- Pinterest Ads API: 광고 캠페인 관리
- Pinterest Catalog API: 상품 피드 연동 (Pinterest Shopping)
- Pinterest Conversions API: 전환 추적

**파트너 프로그램**
- Pinterest Marketing Developer Partner (MDP): 공식 파트너 인증
- 패션·라이프스타일 카테고리에서 구매 의향 높은 사용자 집중

**한국·일본 관련성**: 일본에서 패션·인테리어·요리 카테고리 활성. 한국은 상대적으로 낮음

---

### 1-7. Naver (한국)

**공식 API**
- Naver 검색광고 API: 키워드 광고 캠페인 관리
- Naver 클로바 API: AI 연동
- Naver Shopping API: 스마트스토어 상품 데이터 연동 (파트너사 대상)
- Naver 광고 API: CPA·CPM 광고 자동화

**파트너 프로그램**
- 네이버 파트너스퀘어: 스타트업·SMB 대상 교육·지원 프로그램
- 네이버 공식 검색광고 대행사 인증: 광고비 실적 기반 등급 부여

**한국 커머스에서의 중요도**
- 네이버 쇼핑 검색 트래픽은 한국 이커머스 노출에 필수
- 스마트스토어 연동 vs 독립몰(셀메이트CM 기반) 전략 충돌 가능성 검토 필요

---

## 2. 공식 마케팅 파트너 인증 조건 및 신청 절차 요약

| 플랫폼 | 파트너 신청 경로 | 핵심 조건 |
|--------|----------------|-----------|
| Meta | business.facebook.com/partners | 광고비 $5,000+, Blueprint 인증 |
| TikTok | business-api.tiktok.com/portal | 앱 심사, 데모 제공, 약관 동의 |
| X | developer.twitter.com | 사용 목적 명시, 유료 플랜 가입 |
| LINE | lineapiusecase.com, LINE Biz | 기술 역량 심사, 사양 공유 의향 |
| YouTube | Google Partners | Google Ads 인증 시험 통과 |
| Pinterest | business.pinterest.com/partners | MDP 심사 |
| Naver | searchad.naver.com | 광고 대행 실적 기반 |

---

## 3. 제공 기능 범위 비교

| 기능 | Meta | TikTok | X | LINE | YouTube | Pinterest | Naver |
|------|------|--------|---|------|---------|-----------|-------|
| 광고 캠페인 관리 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 상품 카탈로그 연동 | ✅ | ✅ | ❌ | 제한적 | ✅ | ✅ | ✅ |
| 픽셀·이벤트 추적 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 메시지 발송 | ✅ (WhatsApp) | ❌ | ❌ | ✅ | ❌ | ❌ | ✅ |
| 해시태그 탐색 | ✅ | 제한적 | ✅ | ❌ | ❌ | ❌ | ❌ |
| 소셜 로그인 | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |

---

## 4. API 비용 및 Rate Limit 상세

| 플랫폼 | 기본 API 비용 | 주요 Rate Limit |
|--------|-------------|----------------|
| Meta Marketing API | 무료 (광고비 별도) | 9,000점/계정, 100 QPS (write) |
| Instagram Graph API | 무료 | 200 req/시간/계정, 해시태그 30개/주 |
| TikTok API | 무료 (광고비 별도) | 공식 포털 확인 필요 |
| X API | Free~$5,000+/월 | Free: 1,500 읽기/월 |
| LINE Messaging API | 무료 플랜~유료 | 무료: 월 200건, 유료: 건당 과금 |
| YouTube Data API | 무료 | 10,000 units/일 (기본 쿼터) |
| Pinterest Ads API | 무료 | 파트너 협의 |
| Naver 광고 API | 무료 | 초당 요청 수 제한 (공식 문서 확인) |

---

## 5. 경쟁사 SNS 연동 방식 벤치마크

### 5-1. Shopify
- Meta: Facebook·Instagram Shopping 공식 채널 앱 (원클릭 카탈로그 동기화)
- TikTok: "TikTok for Shopify" 공식 앱 — 광고 자동화 + TikTok Shop 연동
- Pinterest: "Pinterest for Shopify" 공식 앱
- Google/YouTube: "Google & YouTube" 공식 앱 (Merchant Center 자동 동기화)
- 특징: 모든 주요 플랫폼을 **Shopify App Store를 통해 플러그인 형태로 설치** → 기술 부담 없음

### 5-2. 카페24
- Meta·Google: 공식 픽셀 설치 및 광고 연동 기능 내장
- YouTube 쇼핑: 카페24·유튜브 쇼핑 파트너십 (2024 DMTS 발표)
- 네이버: 네이버 스마트스토어·네이버 쇼핑 공식 연동
- 카카오: 카카오톡 채널 연동, 카카오 광고 픽셀 지원
- 특징: 한국 커머스 생태계 중심의 **토종 플랫폼 우선 연동**, 글로벌 연동은 Shopify 대비 제한적

### 5-3. 셀메이트CM 포지셔닝
- Shopify의 글로벌 연동 편의성 + 카페24의 한국·일본 로컬 생태계 강점을 결합하는 것이 목표
- 일본 시장에서는 LINE 연동이 Shopify 대비 차별점

---

## 6. 셀메이트CM 연동 전략 시사점

### 6-1. 우선순위 권고 (한국)

**1순위: Meta (Instagram 중심)**
- 패션·뷰티 카테고리에서 Instagram Shopping 전환율 최고
- Graph API를 통한 브랜드 멘션·해시태그 리뷰 수집 가능
- Catalog API로 상품 피드 자동 동기화

**2순위: Naver**
- 한국 검색 트래픽의 핵심 채널
- 스마트스토어와의 경쟁 포지션 명확화 후 연동 설계

**3순위: TikTok**
- 10~20대 타겟 패션 브랜드에서 급성장 채널
- TikTok Shop 연동으로 소셜 커머스 기능 추가

### 6-2. 우선순위 권고 (일본)

**1순위: LINE**
- 일본 월간 활성 사용자 9,700만+, 메시지 오픈율 압도적
- LINE 공식 계정 + LINE Pay 연동으로 완결형 구매 경험 제공

**2순위: Meta (Instagram)**
- 일본에서도 Instagram 쇼핑 성장세
- 한국과 동일한 API 인프라 활용 가능

**3순위: YouTube Shopping**
- 일본은 유튜버 영향력이 높아 YouTube Shopping 연동 효과적

### 6-3. 기술 구현 권고사항

1. **카탈로그 피드 중앙화**: 셀메이트CM 상품 DB → 단일 피드로 Meta·TikTok·Pinterest·Google Merchant Center 동시 연동
2. **이벤트 추적 통합**: Conversions API(Meta) + TikTok Events API + 공통 픽셀 레이어로 전환 추적 일원화
3. **파트너 신청 로드맵**: Meta Badged Partner 취득 후 TikTok Technology Partner, LINE Technology Partner 순으로 인증 확대
4. **라이트 통합 우선**: 초기에는 API 직접 연동보다 Shopify 앱 스타일의 플러그인형 연동으로 브랜드 설치 부담 최소화

---

## 참고 자료

- Meta Agency First Program 2025: https://about.fb.com/ko/news/2025/02/meta-agency-first-program-2025-official-partners/
- Meta Marketing API Rate Limiting: https://developers.facebook.com/docs/marketing-api/overview/rate-limiting/
- Meta Business Partner Program: https://www.facebook.com/business/marketing-partners/become-a-partner/fmp-product-policies
- TikTok API for Business: https://business-api.tiktok.com/portal
- TikTok Developer Guidelines: https://developers.tiktok.com/doc/our-guidelines-developer-guidelines
- LINE Developer News 2025: https://developers.line.biz/en/news/2025/
- Instagram Partner Program: https://business.instagram.com/blog/introducing-the-instagram-partner-program?locale=ko_KR
- TikTok Shop for Shopify: https://ads.tiktok.com/business/en/guides/tiktok-shop-shopify-setup-guide
