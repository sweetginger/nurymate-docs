# [4-4] Shopify 일본 내 약점 사실 검증

## 조사 결과

### 1. 일본어 지원 부족 (관리자 UI, 고객센터)

**[검증됨 - 부분적으로 사실]**

Shopify는 2017년 이후 일본어 로컬라이제이션을 꾸준히 개선해 왔으나, 여전히 구조적 문제가 남아 있다.

- **관리자 UI**: 기본 관리 화면은 일본어 지원이 되나, 신규 기능이나 앱 대부분은 영어로만 제공되는 경우가 많음. 특히 Shopify Magic (AI 기능)은 2024년 기준 일본어 미지원으로 사용 시 영어로 설정 변경이 필요함.
- **테마(디자인 템플릿)**: 해외 테마 대다수가 영어 기반이며, 고품질 유료 테마는 영어로 제공되는 경우가 대부분.
- **앱 생태계**: 글로벌 앱스토어의 앱들은 일본어 미대응이 많음. 아르바이트·비전문가 직원이 조작하기 어렵다는 불만 사례가 다수 존재함.
- **고객센터**: 일본어 문의 가능하나, 기술 문의나 주말 문의의 경우 회신까지 수 영업일이 소요됨. 실시간 대응 품질이 미흡하다는 평가.

대표 이용자 불만 예시:
- "일본어 대응 안 된 앱이 많아서, 특히 새 앱 도입 시 번거롭다"
- "커스터마이즈에 영어 대응이 많아 영어가 약한 아르바이트 직원에게 업무를 맡길 수 없다"

---

### 2. 일본 특유 기능 부재

**[검증됨 - 대부분 사실, 서드파티 앱으로 보완 필요]**

#### 영수증 (영수증/거래명세서) 발행
Shopify 표준 기능으로는 일본식 영수증(領収書) 발행이 불가능하다. 인보이스 제도(適格請求書) 대응, 경감세율 표시 등 일본 세법 요구사항을 충족하려면 별도 앱 도입이 필수다.

- 대응 방법: BiNDec, ShopifyガイドNetが推薦 등의 영수증 발행 전용 앱 10종 이상이 존재함
- 문제: 앱 비용이 추가로 발생하며, 인보이스 제도(2023년 10월 도입) 대응이 불완전한 경우 존재

#### 商品コード (상품 코드) 표준
일본 내 JAN 코드(EAN-13) 등 국내 표준 상품 코드 관리가 Shopify 기본 기능에서 다소 번거로움. 국내 물류/도매 시스템과 연동 시 매핑 작업이 필요함.

#### 연령 확인
주류·성인 상품 판매에 필요한 일본 표준 연령 확인 기능은 표준 내장 기능으로 제공되지 않으며, 서드파티 앱 의존이 필요함.

#### 消費税 (소비세) 표시 방식
일본에서는 법적으로 세금 포함 가격(내세가격) 표시가 의무화되어 있다. Shopify 기본 설정에서는 세금 포함/제외 표시 방식을 별도 설정해야 하며, 경감세율(8%)과 일반세율(10%) 혼용 상품 처리 시 복잡성이 발생함.

---

### 3. 일본 물류/배송 시스템과의 연동

**[검증됨 - 직접 연동이 아닌 서드파티 앱 의존, 단 기능은 확보 가능]**

Shopify는 일본에서 자체 Shopify Shipping 서비스를 제공하지 않는다. 일본 3대 물류사(ヤマト運輸, 佐川急便, 日本郵便)와의 연동은 모두 서드파티 앱을 통해 구현해야 함.

- **ヤマト運輸 (야마토 운수)**: Shopify Japan과 2024년 3월 공식 파트너십 체결 발표. 기존에는 CSV 방식 연동이 주류였으나 오류 빈발 문제가 있었음. API 연동 앱을 통해 효율화 가능.
- **佐川急便 (사가와 규빈)**: e-Express 시스템과 연동 앱 존재하나, 설정 복잡도 높음.
- **일본郵便 (일본 우정)**: 연동 앱 존재.

주요 문제점:
- Shopify 기본 주문 관리와 배송 앱 간 데이터 충돌 가능성 (같은 주문 데이터에 간섭하는 앱 간 충돌)
- CSV 방식 연동의 경우 시스템 오류 빈발
- 배송 일시 지정, 追跡番号(추적 번호) 자동 통지 등 일본 특유 기능은 전용 앱 필수

2024년 기준, 미쓰이물산(三井物産)의 Plus Shipping 서비스가 야마토·사가와·일본우정 데이터를 통합 관리하여 운영 프로세스를 기존 10단계에서 3단계로 단축, 15분에서 1분으로 단축하는 사례도 등장했다.

---

### 4. 일본 세금 계산 방식

**[검증됨 - 설정 복잡, 단 운영 가능]**

- 일본 소비세법상 세금 포함 표시 의무화(2021년~)에 대해 Shopify 설정으로 대응은 가능하나, 직관적이지 않음.
- 2023년 10월 도입된 인보이스 제도(適格請求書等保存方式) 대응은 Shopify 표준 기능으로는 불가능하며 앱 필요.
- 경감세율(8%) 적용 상품과 일반 세율(10%) 상품 혼용 시, Shopify 표준 기능으로의 자동 분리 처리가 어려움.

---

### 5. 일본 판매자들의 이탈 사례 및 불만

**[검증됨 - 구체적 이탈 사례 존재]**

2024년 12월 Shopify에서 Amazon Pay 연동이 종료되는 이슈가 발생했다. Amazon Pay 유무에 따라 매출 40% 차이가 발생한다는 데이터가 있으며, 이를 계기로 MakeShop으로 이전하는 판매자가 증가했다. MakeShop은 Shopify 이탈 판매자 대상으로 초기 비용 면제 및 6개월 무료 서비스 이전 캠페인을 진행했다.

추가 불만 사례:
- 국내 인지도 저조: BASE, MakeShop 등 일본 국내 플랫폼 대비 Shopify의 일본 내 인지도가 낮아, 고객 신뢰 확보에 어려움을 겪는 사례.
- 데이터 마이그레이션 문제: MakeShop에서 Shopify로 이전 시 고객 데이터 필드 구조 불일치(성명 통합 vs 분리) 등 호환성 문제 발생.
- 앱 비용 누적: 일본 표준 기능 구현을 위한 서드파티 앱 비용이 누적되어 총비용이 예상보다 높아지는 불만.

---

## 결론

Shopify의 일본 내 약점은 크게 세 가지 구조적 문제로 귀결된다. 첫째, 일본 특유의 비즈니스 관행(領収書, 인보이스, 소비세 표시)을 표준 기능으로 지원하지 않아 서드파티 앱 의존이 불가피하며 비용이 누적된다. 둘째, 물류 3사(ヤマト·佐川·日本郵便)와의 직접 연동 미지원으로 운영 복잡도가 높다. 셋째, 2024년 Amazon Pay 종료와 같은 일본 시장 특화 결제 수단 문제가 이탈을 촉진하는 계기가 된 사례가 존재한다.

다만 일부 항목은 서드파티 앱과 파트너십을 통해 기능적으로 보완 가능하여, "불가능"이 아니라 "불편하고 비용이 추가된다"는 수준으로 이해하는 것이 정확하다.

---

## 근거

- Shopify 표준 기능으로 領収書(영수증) 발행 불가 - 전용 앱 10종 이상 존재 확인
- Shopify Shipping 일본 미지원 - 공식 헬프센터 명시
- Shopify Japan × ヤマト運輸 공식 파트너십 발표: 2024년 3월
- Amazon Pay 종료(2025년 1월) 이후 MakeShop 이전 캠페인 실시 확인
- Shopify Magic AI 기능: 일본어 미지원(2024년 기준), 사용 시 영어 설정 전환 필요
- CSV 방식 물류 연동 오류 빈발 사례 다수 확인
- 미쓰이물산 Plus Shipping: 물류 프로세스 10→3단계 단축 사례 확인

---

## 출처

- [Shopifyのサポート体制は？時間や日本語対応の有無を徹底解説](https://plus-shipping.com/blogs/shopify-support)
- [グローバルなShopifyだからこそ気をつけたい、日本固有の5つの注意点](https://makasete-ec.jp/naruhodo/2022/10/21/column0048/)
- [Shopify製ECで日本語の領収書を出す方法](https://bindec.jp/media/389193990203/)
- [【2024】Shopifyでの領収書発行方法は？おすすめアプリ10選](https://shopify-guide.net/shopify-receipt-apps/)
- [Shopifyとヤマト運輸の連携方法は？CSVとAPI連携の違いを解説](https://blog.shipandco.com/shopify-yamato-csv-api-integration/)
- [【2025年最新版】Shopifyとヤマト運輸を連携する方法](https://and-d.tokyo/shopify_app_blog/2899/)
- [Mitsui's Shopify Integration Transforms Japan's E-commerce](https://shopthemedetector.com/blog/mitsuis-shopify-integration-transforms-japans-e-commerce/)
- [Shopify Japan, Inc. & Yamato Transport Partnership PDF (2024.03)](https://www.yamato-hd.co.jp/english/news/2023/pdf/newsrelease_20240307_en01.pdf)
- [ShopifyユーザーのAmazon Pay終了とMakeShopへの乗り換えキャンペーン](https://artpeace.jp/blog/2024/12/05/shopify-makeshop-campaign-tama/)
- [【2025】Shopifyで日本語にならない時に必ず入れるべきアプリ15選](https://unreact.jp/blog/shopify-not-japanese-app-15-selection)
- [Shopify Integration in Japan in 2025 - Komoju](https://en.komoju.com/blog/general-advice/shopify-integration-in-japan/)
- [Shopify Help Center | Shipping in Japan](https://help.shopify.com/en/manual/intro-to-shopify/initial-setup/sell-in-japan/japan-shipping)

---

## [4-4] Shopify 일본 약점 사실 검증 결과

각 약점 항목을 웹서치 및 공식 문서로 교차 검증한 결과:

| 약점 항목 | 검증 결과 | 근거 |
|---------|---------|------|
| 콘비니(コンビニ)·은행이체 결제 네이티브 미지원 | **사실** | Shopify Payments Japan은 Visa/MC/JCB/AMEX 카드 및 PayPay·LINE Pay 등 디지털지갑을 네이티브 지원하나, 콘비니 결제(コンビニ決済)·Pay-easy 은행이체·Paidy 후불은 KOMOJU·GMO Epsilon·SB Payment Service 등 서드파티 PG를 통해서만 제공 가능. Shopify Payments 단독으로는 불가. |
| 領収書(영수증) 발행 기능 기본 미내장 | **사실** | Shopify 표준 기능으로 일본식 영수증(領収書) 발행 불가. BiNDec, Shopify Guide Net 추천 앱 등 10종 이상의 전용 앱 설치 필수. |
| 일본 인보이스 제도(適格請求書) 대응 부재 | **사실** | 2023년 10월 도입된 인보이스 제도(適格請求書等保存方式) 대응은 Shopify 기본 기능으로 불가. 등록번호 표기, 세율별 세액 분리 표시 등 요건 충족을 위해 전용 앱 필수. Stripe·Komoju 등 외부 PG가 자체적으로 일부 컴플라이언스를 처리하는 사례는 있으나 Shopify 플랫폼 자체 기능은 아님. |
| 연령 확인(年齢確認) 기능 미내장 | **사실** | Shopify 기본 기능(Dawn 등 무료 테마 포함)에는 연령 확인 기능이 없음. 일부 유료 테마(Impulse, Empire)에 포함되어 있으나 표준 내장 기능이 아님. 주류·성인용품·의약품 판매 시 年齢確認サポーター, UR:DOB, CC Age Verification 등 앱 또는 커스텀 코드 구현 필요. |
| Shopify 일본 고객 지원 품질 이슈 | **대체로 사실** | 일본어 문의는 가능하나 기술적 문의·주말 문의의 경우 수 영업일 소요 사례 다수. Shopify Magic(AI 기능)이 2024년 기준 일본어 미지원으로 영어 설정 전환 필요. 앱 대다수가 영어 기반으로 비영어권 직원 운용 어려움. |

### 추가 발견 사항

- **Shopify Payments Japan 현황 (2025년 기준)**: Shopify Payments는 일본에서 지원되며, PayPay·LINE Pay·Merpay·au PAY·d Payment·Rakuten Pay·Paidy·Alipay·WeChat Pay 등 다양한 일본 결제수단을 Shopify Payments 내에서 활성화 가능. 단, 콘비니 결제와 Pay-easy 은행이체는 여전히 별도 서드파티 PG(KOMOJU 등) 필요.
- **2025년 1월 Amazon Pay 연동 종료**: 일본 Shopify 판매자 대상 Amazon Pay 지원이 2025년 1월 6일 종료됨. Amazon Pay 유무에 따라 매출 최대 40% 차이가 발생한다는 데이터가 있어 일부 판매자의 MakeShop 이전 계기가 됨.

### [4-4] 검증 출처

- [Shopify Integration in Japan in 2025 - Komoju](https://en.komoju.com/blog/general-advice/shopify-integration-in-japan/)
- [Shopify + Konbini: Japanese Merchant Payment Guide - CartDNA](https://www.cartdna.com/shopify-payment-methods/konbini)
- [Shopify Payment Methods in Japan - CartDNA](https://www.cartdna.com/shopify-payment-guide/asia-east/japan)
- [Shopify Help Center | Shopify Payments for Japan](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries/japan)
- [Shopify's payment methods in Japan (JP official)](https://www.shopify.com/jp/blog/payments-list-en)
- [Shopifyで生年月日に応じた年齢確認を行う方法 - Qiita](https://qiita.com/eijiSaito/items/ab663a035d9191f0a1fb)
- [【2025年】Shopifyで生年月日入力による年齢確認を実現する方法 - Unreact](https://unreact.jp/blog/shopify-age-confirmation-dob)
- [Shopify to End Amazon Pay for Japanese Merchants - Forest Shipping](https://www.forestshipping.com/shopify-to-end-amazon-pay-japanese-merchants-January-2025)
- [Japan's Qualified Invoice System - Stripe](https://stripe.com/resources/more/qualified-invoices-in-japan)

---

## [4-5] Shopify·카페24 지원 국가 및 결제수단 비교

### Shopify 지원 현황

#### 스토어 개설 가능 국가
- **175개국 이상**에서 Shopify 스토어 개설 가능 (플랫폼 자체는 글로벌 지원)

#### Shopify Payments 지원 국가 (2025년 기준)
Shopify Payments는 현재 **약 19~33개국**에서 직접 지원됨. 2025년 3월 15개 유럽 국가 추가 확대 발표.

핵심 지원 국가 목록:
- **아시아·태평양**: 일본(Japan), 홍콩(Hong Kong SAR), 싱가포르, 호주, 뉴질랜드
- **북미**: 미국, 캐나다
- **유럽**: 영국, 아일랜드, 독일, 프랑스, 이탈리아, 스페인, 네덜란드, 벨기에, 오스트리아, 덴마크, 핀란드, 스웨덴 + 2025년 신규 15개국(폴란드, 리투아니아, 노르웨이, 라트비아, 헝가리, 에스토니아, 몰타, 크로아티아, 그리스, 슬로베니아, 키프로스, 불가리아, 리히텐슈타인, 룩셈부르크, 지브롤터)
- **미지원 주요 국가**: 한국, 인도, 파키스탄, 나이지리아, UAE, 남아프리카, 대부분 중남미 지역

#### 일본 결제수단 지원 현황 (2025년)
| 결제 유형 | 지원 여부 | 비고 |
|---------|---------|------|
| 신용카드(Visa/MC/JCB/AMEX) | 네이티브 지원 | Shopify Payments |
| PayPay | 네이티브 지원 | Shopify Payments |
| LINE Pay, Merpay, au PAY, d Payment, Rakuten Pay | 네이티브 지원 | Shopify Payments |
| Paidy (후불) | 네이티브 지원 | Shopify Payments |
| Alipay, WeChat Pay | 네이티브 지원 | Shopify Payments |
| 콘비니 결제(コンビニ決済) | **서드파티 필요** | KOMOJU, GMO Epsilon 등 |
| Pay-easy 은행이체 | **서드파티 필요** | KOMOJU, SBPS 등 |
| Amazon Pay | **지원 종료** | 2025년 1월 6일 종료 |

#### 한국 결제수단 지원 현황 (2025년)
- Shopify Payments **한국 미지원** (Shopify Payments 지원 국가 목록에 한국 없음)
- 한국 판매자는 서드파티 PG(NHN KCP, 이니시스, 토스페이먼츠 등) 사용 필수
- 네이버페이·카카오페이 등 국내 간편결제는 별도 앱 필요

---

### 카페24 지원 현황

#### 서비스 지원 국가 및 현지화 수준

| 국가/지역 | 서비스 유형 | 현지화 수준 |
|---------|---------|---------|
| 한국 | 풀 서비스 (본사) | 최고 (PG 직연동, 배송사 직연동, 완벽 현지화) |
| 일본 | 현지 법인 + 서비스 | 높음 (KG이니시스 파트너십으로 현지 결제 서비스 2026년 출시, SoftBank Japan 파트너) |
| 베트남 | 현지 법인 + 서비스 | 중간 (다국어 지원, Paymentwall 연동) |
| 대만 | 현지 법인 | 중간 (繁體中文 지원) |
| 필리핀 | 현지 법인 | 초기 단계 |
| 미국 | 현지 법인 | 글로벌 D2C 지원 거점 |
| 중국 | 현지 법인 | 역직구(해외직구) 지원 |
| 기타 200개국 | 글로벌 배송·결제 | 패스트박스(FastBox) 200개국 배송, Paymentwall·PayPal 결제만 지원 |

#### 카페24의 현지화 특성
- **한국 집중도 매우 높음**: 등록 쇼핑몰의 99.6%가 한국에 집중 (StoreleadsApp, 2025년)
- **실질적 다국적 운영 한계**: 국가별 별도 쇼핑몰 생성 방식으로 통합 글로벌 운영 효율 저하
- **글로벌 파트너십**: Google, Meta, PayPal, Amazon, Shopee, T-mall Global, Rakuten, TikTok, Alibaba 그룹, SoftBank(일본) 등 126개 이상 파트너
- **일본 전략**: 2026년 1월 KG이니시스와 파트너십 체결, 일본 현지 결제수단(コンビニ決済, 銀行振込, J-Debit 등) 지원 서비스 출시 발표

#### Shopify vs 카페24 결제 지원 비교 요약

| 항목 | Shopify | 카페24 |
|------|---------|-------|
| Shopify Payments / 자체 PG 지원국 | 약 33개국 (2025년 기준) | 한국 (자체 PG), 일본·베트남 등은 파트너 PG |
| 일본 콘비니 결제 | 서드파티 필요 (KOMOJU 등) | KG이니시스 파트너십으로 2026년 지원 예정 |
| 한국 결제 | 서드파티 필요 (Shopify Payments 미지원) | 자체 PG + 카카오페이·네이버페이·토스 완벽 지원 |
| 글로벌 스토어 개설 | 175개국 이상 가능 | 200개국 배송 가능, 현지화는 7개국 수준 |

### [4-5] 출처

- [Shopify Help Center | Supported countries for Shopify Payments](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries)
- [What Countries Does Shopify Support? (2025 Merchant Guide) - SellioApps](https://www.sellioapps.com/blogs/news/what-countries-does-shopify-support-2025-guide)
- [Shopify Payments available in 15 additional European Countries - Shopify Changelog](https://changelog.shopify.com/posts/shopify-payments-available-in-14-additional-european-countries)
- [Shopify Help Center | Shopify Payments for Japan](https://help.shopify.com/en/manual/payments/shopify-payments/supported-countries/japan)
- [Shopify Integration in Japan in 2025 - Komoju](https://en.komoju.com/blog/general-advice/shopify-integration-in-japan/)
- [Cafe24, No.1 Global E-commerce Platform](https://www.cafe24corp.com/en/company/about)
- [The State of Cafe24 in 2025 - StoreleadsApp](https://storeleads.app/reports/cafe24)
- [카페24, KG이니시스와 K-브랜드 일본 진출 지원 - 머니투데이](https://www.mt.co.kr/stock/2026/01/20/2026012009343073350)
- [How Cafe24 became a global e-commerce platform - Cafe24 Newsroom](https://news.cafe24.com/global/how-cafe24-became-a-global-e-commerce-platform/)
- [cafe24 - Wikipedia](https://en.wikipedia.org/wiki/Cafe24)
