# 글로벌 진출 지원 기능 기획서 [10-4]

> 작성일: 2026-03-06 | 마감: 2026-03-25 전략 회의

---

## 1. 개요 — "원클릭 글로벌 진출"

### 1.1 배경 및 목적

셀메이트CM의 핵심 차별화 전략 중 하나는 **한국 판매자가 해외 시장에 진출하는 전체 과정을 플랫폼이 자동화**하는 것이다. 현재 Shopify Markets는 단일 스토어에서 다국가 관리를 지원하나, 구조적 한계가 분명하다.

**Shopify Markets의 현재 한계**:
- 번역은 Translate & Adapt 앱 또는 CSV 방식에 의존 — 자동화 수준 낮음
- 상품 이미지 내 텍스트(한국어 라벨, 패키지 문구 등) 번역 기능 없음
- 국가별 SEO 최적화(hreflang 등)는 서드파티 앱 필요
- 번역 품질 검토·승인 워크플로우 없음 — 기계번역 오류가 스토어에 바로 노출됨
- 통화·세금 설정은 수동 구성 필요 (2025년 Editions에서 일부 개선)

셀메이트CM은 이 모든 과정을 **판매자가 "일본에서도 판매하기" 버튼 하나로 시작**할 수 있는 수준으로 자동화한다.

### 1.2 시장 규모

- 글로벌 이커머스 총 거래액(2025): **USD 4.32조**
- OCR 시장(2025): **USD 143.6억**, 2033년까지 CAGR 17.23% 성장 예상
- 글로벌 K-뷰티 시장(2025): **USD 162.6억**, 2033년 USD 382.9억 예상 (CAGR 11.3%)
- 동남아 K-뷰티 시장(2025): **USD 44억**, 2035년 USD 111억 예상 (CAGR 9.6%)

한국 브랜드의 글로벌 수요는 실증적으로 확인된다. 판매자가 해외 진출 시 겪는 핵심 장벽은 언어·콘텐츠 현지화이며, 이를 자동화하면 셀메이트CM은 카페24·Shopify 대비 명확한 우위를 확보한다.

### 1.3 핵심 설계 원칙

| 원칙 | 내용 |
|------|------|
| **판매자 최소 조작** | 국가 선택 → 자동 처리 → 검토·승인만 필요 |
| **품질 보장** | 기계번역 결과를 판매자가 검토·수정할 수 있는 워크플로우 필수 |
| **단계적 오픈** | 완벽한 자동화보다 "충분히 좋은 자동화 + 쉬운 수정" 먼저 |
| **현지화 = 이미지 포함** | 텍스트 번역만으로 불충분. 이미지 내 한국어 텍스트도 번역 대상 |

---

## 2. 핵심 기능 정의

### 2.1 이미지 자동 현지화 (AI 기반)

> **[참고용]** 아래 구현 로직은 성배님이 기구현한 내용을 기반으로 작성되었습니다. 실제 적용 시 기구현 코드를 우선 검토하고 필요한 부분만 보완하세요.

#### 배경

한국 이커머스 상품 이미지에는 한국어 텍스트가 빈번하게 포함된다 — 성분 라벨, 사용법, 효능 문구, 프로모션 배너 등. 이를 번역하지 않으면 해외 고객에게 신뢰도와 구매 전환율이 급격히 하락한다.

#### 기술 접근

```
[단계 1] OCR — 이미지 내 텍스트 영역 감지
         └→ Google Cloud Vision API / Azure Computer Vision / Mistral OCR (2025년 업계 벤치마크 1위)
                    ↓
[단계 2] 번역 — 감지된 텍스트 번역
         └→ DeepL API (유럽·일본어 자연스러운 번역으로 정평) + Papago (한→일 특화)
                    ↓
[단계 3] 이미지 재생성 — 원래 위치에 번역된 텍스트를 동일 폰트/레이아웃으로 삽입
         └→ Stable Diffusion Inpainting / Adobe Firefly API / 자체 렌더링 엔진
```

**2025~2026년 기술 현황**: Smartcat의 Image Translation Agent, ImageTranslate.AI, OpenL 등이 이미 이 워크플로우를 상용화. OCR + 번역 + 레이아웃 복원 파이프라인은 기술적으로 검증된 상태. Mistral OCR(2025년 초 출시)이 복잡한 이미지·혼합 포맷 처리에서 업계 기준 최고 수준으로 평가받음.

#### 기능 명세

| 항목 | 내용 |
|------|------|
| 트리거 | 판매자가 "글로벌 진출" 기능 활성화 → 기존 상품 이미지 일괄 처리 또는 신규 이미지 업로드 시 자동 처리 |
| 처리 범위 | 상품 이미지, 상세페이지 배너, 썸네일 |
| 판매자 인터뷰 | 원본 이미지 + 번역본 이미지 나란히 표시 → 승인/거절/수동 수정 |
| 미처리 케이스 | 예술적 폰트, 손글씨, 매우 작은 텍스트는 "수동 번역 필요" 태그로 분류 |
| 저장 방식 | 국가별 이미지 버전 별도 저장 (원본 훼손 없음) |

#### 주의 사항

기계번역 이미지를 검토 없이 바로 노출할 경우 오번역으로 인한 브랜드 이미지 훼손이 발생할 수 있다. HSBC의 "Assume Nothing" → "do nothing" 오역 사례($1,000만 수습 비용), KFC 중국 진출 슬로건 오역 사례 등에서 보듯, 번역 품질 검토 워크플로우는 선택이 아닌 필수다.

---

### 2.2 콘텐츠 전체 자동 현지화

#### 번역 대상 범위

| 콘텐츠 유형 | 우선순위 | 자동화 수준 |
|------------|---------|-----------|
| 상품명 | 최상 | 자동 번역 + 검토 |
| 상품 설명 (단문) | 최상 | 자동 번역 + 검토 |
| 상품 설명 (장문/HTML) | 상 | 자동 번역 + 검토 (HTML 태그 보존) |
| 카테고리명 | 상 | 자동 번역 |
| 메타 타이틀·설명 (SEO) | 상 | 자동 번역 + 키워드 최적화 제안 |
| 약관·환불정책 | 중 | 템플릿 제공 + 커스텀 가능 |
| 공지사항·이벤트 배너 | 중 | 자동 번역 + 검토 |
| 이메일 템플릿 (주문 확인 등) | 중 | 자동 번역 |
| 고객센터 FAQ | 하 | 수동 번역 보조 툴 제공 |

#### 지원 언어 우선순위

| 단계 | 언어 | 시장 |
|------|------|------|
| Phase 1 (2025~2026) | 일본어 | 일본 |
| Phase 2 (2027) | 영어 | 글로벌 기본값 |
| Phase 2 (2027) | 인도네시아어, 태국어 | 동남아 |
| Phase 3 (2028) | 베트남어, 말레이어 | 동남아 확장 |
| Phase 4 (2028~) | 번체 중국어 | 대만 |
| Phase 4 (2028~) | 아랍어 | 중동 |

#### 번역 엔진 선택 근거

- **한→일**: DeepL (자연스러운 번역 평가 1위) + Papago (한일 특화)
- **한→영**: DeepL + Google Translate (130개 언어 지원)
- **한→동남아**: Google Translate (인도네시아어, 태국어, 베트남어, 말레이어 지원)
- **품질 모니터링**: 번역 신뢰도 점수 표시 — 낮은 점수는 검토 우선순위 높임

---

### 2.3 현지화 품질 관리 워크플로우

#### 핵심 설계 철학

기계번역을 그대로 노출하지 않는다. **반드시 판매자 검토 단계를 거친다.** 이것이 Shopify Markets의 Translate & Adapt 앱과의 차별점이다.

#### 워크플로우 설계

```
[1단계] 자동 번역 실행
   └→ 번역 완료 → 대시보드에 "검토 필요" 뱃지 표시

[2단계] 판매자 검토 인터페이스
   └→ 원문 / 번역 병렬 표시
   └→ 신뢰도 점수 표시 (높음/중간/낮음)
   └→ 낮은 점수 항목은 상단에 정렬 (우선 검토)

[3단계] 수정 & 승인
   └→ 판매자 직접 수정 가능
   └→ 항목별 승인 또는 일괄 승인
   └→ 승인 전까지 해당 국가 스토어에 미반영

[4단계] 전문 번역가 의뢰 (선택)
   └→ 플랫폼 내 번역가 마켓플레이스 연결 (파트너십)
   └→ 검토 완료된 번역 재사용 (번역 메모리 누적)

[5단계] 지속적 개선
   └→ 판매자 수정 이력으로 번역 모델 파인튜닝
   └→ 동일 브랜드/도메인 내 용어 일관성 유지 (용어집 기능)
```

#### 번역 메모리 (Translation Memory)

동일 판매자의 수정 이력을 축적하여 유사 문구 재번역 시 자동 적용. 브랜드 고유 용어(브랜드명, 제품 라인명 등)는 번역하지 않도록 예외 처리 가능.

---

### 2.4 국가별 SEO 최적화

#### hreflang 자동 설정

hreflang은 Google에게 동일 페이지의 언어/국가별 버전을 알려주는 HTML 속성으로, 국제 이커머스 SEO의 핵심이다. 잘못 구현 시 중복 콘텐츠로 인식되어 검색 순위가 하락한다.

**셀메이트CM 자동화 방식**:

```html
<!-- 예시: 한국 스토어의 상품 페이지 -->
<link rel="alternate" hreflang="ko-KR" href="https://store.sellmatecm.com/ko/products/item-001" />
<link rel="alternate" hreflang="ja-JP" href="https://store.sellmatecm.com/ja/products/item-001" />
<link rel="alternate" hreflang="en"    href="https://store.sellmatecm.com/en/products/item-001" />
<link rel="alternate" hreflang="x-default" href="https://store.sellmatecm.com/products/item-001" />
```

| 자동화 항목 | 내용 |
|------------|------|
| hreflang 태그 자동 생성 | 국가 진출 설정 시 모든 페이지(상품/카테고리/컨텐츠)에 자동 삽입 |
| 자기참조(self-referencing) 태그 | 각 페이지가 자신을 참조하는 태그 필수 포함 (누락 시 Google 무시) |
| 국가별 도메인 구조 | 서브디렉토리(/ja/, /en/) 또는 서브도메인(ja.store.com) 선택 가능 |
| sitemap.xml 자동 업데이트 | 신규 언어 버전 추가 시 sitemap에 자동 반영 |
| Google Search Console 연동 | International Targeting 오류 모니터링 대시보드 제공 |

**구현 시 주의사항**: 모든 언어 버전이 서로를 상호 참조해야 하며(return tag), 절대 URL을 사용해야 한다. 상품 수천 개 × 수십 개 국가 = 수만 개의 태그를 수동으로 관리하는 것은 현실적으로 불가능하므로, 자동화가 핵심 경쟁력이다.

#### 현지 검색엔진 메타데이터

| 시장 | 주요 검색엔진 | 특화 메타데이터 |
|------|------------|--------------|
| 일본 | Google Japan, Yahoo! Japan | og:locale, description 일본어 최적화 |
| 인도네시아 | Google | 현지 키워드 제안 기능 |
| 태국 | Google | 태국어 메타데이터 |
| 대만 | Google Taiwan | 번체 중국어 (zh-TW) |
| 중동 | Google MENA | 아랍어 RTL 레이아웃 지원 |

---

### 2.5 통화·세금 자동 설정

#### 통화 자동 적용

| 국가 | 기본 통화 | 소수점 표기 | 통화 기호 위치 |
|------|---------|-----------|-------------|
| 일본 | JPY (¥) | 소수점 없음 | 앞 |
| 인도네시아 | IDR (Rp) | 없음 | 앞 |
| 태국 | THB (฿) | 2자리 | 앞 |
| 베트남 | VND (₫) | 없음 | 뒤 |
| 대만 | TWD (NT$) | 2자리 | 앞 |
| UAE | AED (د.إ) | 2자리 | 앞 |

#### 세금·부가가치세 자동 설정

| 국가 | 세율 | 특이사항 |
|------|------|---------|
| 일본 | 소비세 10% (경감세율 8%) | 인보이스 제도 대응 필수 (2023년 도입) |
| 인도네시아 | PPN 11% | QRIS 결제 시 별도 처리 |
| 태국 | VAT 7% | |
| 베트남 | VAT 10% (일부 5%) | |
| 대만 | 영업세 5% | |
| UAE | VAT 5% | |

**자동화 로직**: 판매자가 진출 국가 선택 → 해당 국가의 세율, 통화, 가격 표시 방식(세포함/세별도) 자동 적용. 경감세율 적용 상품(일본 식품 등)은 카테고리 매핑으로 자동 분류.

---

## 3. 사용자 여정 (판매자 관점)

### 3.1 "일본에서도 판매하기" 버튼 클릭 → 라이브 전체 흐름

```
Step 1. 글로벌 진출 대시보드에서 "일본" 선택
   └→ 소요 시간: 30초
   └→ 일본 시장 정보 카드 표시 (시장 규모, 주요 결제수단, 예상 비용)

Step 2. 자동 처리 시작 (백그라운드, 판매자 개입 없음)
   └→ 모든 상품명/설명 일본어 자동 번역
   └→ 상품 이미지 내 한국어 텍스트 감지 → 일본어로 재생성
   └→ 통화 JPY 설정, 소비세 10% 적용
   └→ hreflang ja-JP 태그 전체 페이지 자동 삽입
   └→ 일본 결제수단(카드, PayPay, 콘비니 결제 등) 활성화 안내
   └→ 처리 완료 시 이메일/대시보드 알림

Step 3. 판매자 검토
   └→ "검토 필요 항목 142개" 알림
   └→ 신뢰도 낮은 번역 상단 표시
   └→ 상품별 원문/번역 병렬 검토 인터페이스
   └→ 이미지: 원본/번역본 슬라이더로 비교
   └→ 필요 시 전문 번역가 의뢰 버튼 (1~3일 소요)

Step 4. 가격 설정
   └→ 환율 기반 자동 환산 가격 제안
   └→ 판매자 가격 조정 가능 (마켓별 가격 차별화 지원)
   └→ 라운딩 규칙 설정 (예: 1,980엔, 9,800엔 등 일본식 가격 제안)

Step 5. 최종 승인 및 라이브
   └→ "일본 스토어 오픈" 버튼 클릭
   └→ 일본 고객은 자동으로 일본어 버전으로 리다이렉트
   └→ SEO 색인 요청 자동 제출 (Google Search Console API)
```

### 3.2 판매자 대시보드 핵심 지표

진출 후 국가별 성과 모니터링:

- 국가별 방문자 수 / 전환율 / 매출
- 번역 품질 점수 (수정 빈도, 고객 반응)
- 결제 수단별 전환율
- hreflang 오류 건수 (Google Search Console 연동)

---

## 4. 기술 아키텍처 개요

### 4.1 핵심 컴포넌트

```
┌─────────────────────────────────────────────────────┐
│                  글로벌 진출 오케스트레이터                │
│  (국가 선택 → 작업 큐 → 상태 추적 → 완료 알림)           │
└─────────────────────────────────────────────────────┘
         │              │              │
         ▼              ▼              ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ 이미지 현지화  │ │ 텍스트 번역   │ │ SEO/설정 자동 │
│   파이프라인  │ │   파이프라인  │ │  화 파이프라인 │
│              │ │              │ │              │
│ OCR 엔진     │ │ 번역 API     │ │ hreflang 생성 │
│ (Vision API/ │ │ (DeepL/     │ │ sitemap 업데이 │
│  Mistral)    │ │  Papago/    │ │ 트           │
│              │ │  Google)    │ │              │
│ 이미지 재생성 │ │ 번역 메모리  │ │ 통화/세금     │
│ (Inpainting) │ │ 품질 점수    │ │ 자동 설정    │
└──────────────┘ └──────────────┘ └──────────────┘
         │              │              │
         └──────────────┴──────────────┘
                        │
                        ▼
         ┌─────────────────────────┐
         │   판매자 검토 인터페이스   │
         │  (원문/번역 병렬, 승인)   │
         └─────────────────────────┘
```

### 4.2 외부 API 의존성

| 기능 | 1순위 API | 대안 |
|------|----------|------|
| OCR | Google Cloud Vision API | Azure Computer Vision, Mistral OCR |
| 번역 (한→일) | DeepL API | Papago, Google Translate |
| 번역 (한→기타) | Google Translate API | DeepL |
| 이미지 재생성 | Adobe Firefly API | Stable Diffusion (자체 호스팅) |
| 번역 품질 평가 | Comet 메트릭 (자체 구현) | LLM 기반 평가 |

### 4.3 데이터 모델 개요

```
Product
├── translations: ProductTranslation[]  // 언어별 번역본
│   ├── locale: string (ja-JP, en, id-ID ...)
│   ├── name: string
│   ├── description: string
│   ├── status: draft | reviewed | approved
│   └── quality_score: float
│
└── images: ProductImage[]
    ├── original_url: string
    ├── localized_versions: LocalizedImage[]
    │   ├── locale: string
    │   ├── url: string
    │   └── ocr_regions: OcrRegion[]  // 번역된 텍스트 영역 좌표
    └── has_embedded_text: boolean

Market
├── country_code: string
├── currency: string
├── tax_rate: float
├── reduced_tax_rate: float | null
├── tax_inclusive: boolean
└── hreflang: string
```

---

## 5. 구현 우선순위 (Phase별)

### Phase 1: 텍스트 현지화 기반 구축 (2026 Q2 ~ Q3)

**목표**: 일본 진출 판매자가 텍스트 번역 워크플로우를 사용할 수 있음

| 기능 | 우선순위 | 난이도 | 기간 |
|------|---------|--------|------|
| 상품명/설명 자동 번역 (한→일) | P0 | 중 | 4주 |
| 번역 검토·승인 인터페이스 | P0 | 중 | 3주 |
| 통화/세금 자동 설정 (일본) | P0 | 하 | 2주 |
| hreflang 자동 생성 (일본) | P1 | 중 | 3주 |
| 번역 메모리 기본 구현 | P1 | 중 | 4주 |

### Phase 2: 이미지 현지화 (2026 Q2)

**목표**: 상품 이미지 내 텍스트 자동 번역

| 기능 | 우선순위 | 난이도 | 기간 |
|------|---------|--------|------|
| OCR 텍스트 감지 파이프라인 | P0 | 상 | 5주 |
| 번역된 텍스트 이미지 재삽입 | P0 | 상 | 6주 |
| 이미지 검토 인터페이스 (슬라이더) | P1 | 중 | 3주 |
| 처리 불가 이미지 수동 처리 안내 | P1 | 하 | 1주 |

### Phase 3: 다국어 확장 (2026 Q3 ~ Q4)

**목표**: 영어, 인도네시아어, 태국어 추가

| 기능 | 우선순위 | 난이도 | 기간 |
|------|---------|--------|------|
| 다국어 번역 엔진 통합 (EN, ID, TH) | P0 | 중 | 4주 |
| 국가별 SEO 최적화 확장 | P1 | 중 | 3주 |
| 전문 번역가 마켓플레이스 연결 | P2 | 상 | 6주 |

### Phase 4: 지능형 현지화 (2027)

**목표**: 번역 품질 자동 향상, 문화적 맞춤화

| 기능 | 우선순위 | 난이도 | 기간 |
|------|---------|--------|------|
| 판매자 수정 이력 기반 파인튜닝 | P1 | 상 | 8주 |
| 문화적 색감/이미지 적합성 체크 (AI) | P2 | 상 | 8주 |
| 국가별 프로모션 캘린더 자동 제안 | P2 | 중 | 4주 |

---

## 6. KPI 및 성공 지표

### 6.1 기능 사용 지표 (Adoption)

| KPI | 목표 (Phase 1 출시 6개월 후) |
|-----|---------------------------|
| 글로벌 진출 기능 활성화 판매자 수 | 전체 판매자의 15% |
| 일본 진출 완료 (스토어 라이브) 판매자 수 | 500개 이상 |
| 번역 검토 완료율 | 70% 이상 |
| 이미지 현지화 처리 성공률 | 80% 이상 (텍스트 감지 정확도 기준) |

### 6.2 품질 지표 (Quality)

| KPI | 목표 |
|-----|------|
| 번역 후 판매자 수정률 | 30% 미만 (수정 없이 승인) |
| hreflang 오류 건수 | 스토어당 0건 (자동 검증으로 보장) |
| 번역 신뢰도 점수 낮음 비율 | 10% 미만 |

### 6.3 비즈니스 영향 지표 (Impact)

| KPI | 목표 |
|-----|------|
| 글로벌 진출 판매자의 해외 매출 비중 | 첫 6개월 내 전체 매출의 20% 이상 |
| 글로벌 진출 기능으로 인한 플랫폼 이탈 방지 | 글로벌 진출 활성화 판매자 이탈률 50% 감소 |
| 해외 매출 발생 판매자의 플랜 업그레이드율 | 40% 이상 |

### 6.4 기술 성능 지표 (Performance)

| KPI | 목표 |
|-----|------|
| 텍스트 번역 처리 속도 | 상품 100개 기준 5분 이내 |
| 이미지 현지화 처리 속도 | 이미지 1장 기준 30초 이내 |
| 번역 API 가용성 | 99.9% 이상 |

---

## 출처

- [Best AI Image Translators in 2026 - ImageTranslate.AI](https://imagetranslate.ai/blog/best-ai-image-translators-in-2026)
- [Top 5 AI-Based OCR Solutions for 2026 - VAO World](https://www.vao.world/blogs/top-5-ai-based-ocr-solutions-for-2026)
- [AI-Powered OCR Translation - Transleyt.com](https://transleyt.com/en/blog/ai-powered-ocr-translation-document-localization/)
- [Best AI Translation Tools for E-commerce in 2026 - Reverie](https://reverieinc.com/blog/ai-translation-ecommerce-websites/)
- [Shopify Help Center | Localization and translation](https://help.shopify.com/en/manual/international/localization-and-translation)
- [Shopify Markets & Localization Guide - OSC Professionals](https://www.oscprofessionals.com/shopify/how-shopify-localization-helps-you-create-different-content-for-markets-countries-using-liquid/)
- [What is Shopify Markets and How to Use It | 2025 Guide - Charle](https://www.charle.co.uk/articles/what-is-shopify-markets/)
- [When a Global Journey Goes South: 10 Examples of Bad Translation - Phrase](https://phrase.com/blog/posts/5-examples-localization-gone-tragically-awry/)
- [Global customers on the line: how to master common localization mishaps - RWS](https://www.rws.com/blog/global-customers-on-the-line/)
- [What Is Hreflang and How To Implement It the Right Way in 2025 - Backlinko](https://backlinko.com/hreflang-tag)
- [Hreflang Tags for Multilingual SEO: Best Practices for E-commerce - NEXT BASKET](https://nextbasket.com/the-impact-of-hreflang-tags-on-multilingual-seo-best-practices/)
- [Are Hreflang Tags a Powerful SEO Fix or a Costly Mistake 2026? - ClickRank](https://www.clickrank.ai/hreflang-tags-complete-guide/)
