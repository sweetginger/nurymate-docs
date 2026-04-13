# 멀티테넌시 도메인 구조 기획서

**문서 번호**: SPEC-DOMAIN-001
**작성일**: 2026-03-11
**상태**: Draft
**관련 태스크**: [13-1]

---

## 1. 개요

셀메이트CM는 다수의 셀러가 하나의 플랫폼 인프라를 공유하는 멀티테넌트 구조로 운영된다. 각 셀러는 고유한 도메인(서브도메인 또는 커스텀 도메인)을 통해 자신만의 독립적인 쇼핑몰을 운영한다.

### 1.1 도메인 구조 원칙

- **서브도메인 자동 생성**: 가입 시 `{셀러ID}.sellmatecm.com` 자동 생성
- **커스텀 도메인 연결**: 셀러 소유 도메인을 셀메이트CM 스토어에 연결 가능
- **URL path 리디렉션 금지**: `sellmatecm.com/store/{셀러ID}` 형태의 path 기반 구조 사용 금지. 각 셀러는 독립 도메인(서브도메인 또는 커스텀 도메인)으로만 운영
- **HTTPS 자동 발급**: 서브도메인 및 커스텀 도메인 모두 SSL 인증서 자동 발급·갱신 (Let's Encrypt)

---

## 2. 서브도메인 자동 생성

### 2.1 서브도메인 구조

```
{셀러ID}.sellmatecm.com
예시: brand-name.sellmatecm.com
```

### 2.2 셀러ID 정책

| 규칙 | 내용 |
|------|------|
| 길이 | 3~30자 |
| 허용 문자 | 영소문자, 숫자, 하이픈(-). 시작·끝은 영소문자/숫자만 |
| 중복 | 선착순 단독 소유 |
| 예약어 | www, api, admin, app, mail, static 등 시스템 예약어 사용 불가 |
| 변경 | 최초 1회 변경 가능 (URL 변경 영향 범위 고지 후 확인) |

### 2.3 가입 시 자동 생성 플로우

```
셀러 가입 완료
    │
    ▼
셀러ID 입력 (온보딩 Step 1)
    │
    ├─ 중복 확인 (실시간 검사)
    ├─ 예약어 검사
    └─ 허용 문자 검사
         │
         ▼
서브도메인 즉시 생성
    │
    ▼
DNS 레코드 자동 등록 (Wildcard *.sellmatecm.com → 로드밸런서)
    │
    ▼
SSL 인증서 발급 (Let's Encrypt Wildcard)
```

---

## 3. 커스텀 도메인 연결

### 3.1 커스텀 도메인 연결 방식

셀러가 소유한 도메인(예: `mybrand.com`)을 셀메이트CM 스토어에 연결하는 방식:

| 방식 | DNS 설정 | 적용 대상 |
|------|---------|---------|
| CNAME 방식 | `mybrand.com` → CNAME `nurymate-proxy.sellmatecm.com` | 일반 도메인 |
| A 레코드 방식 | `mybrand.com` → A `[셀메이트CM IP]` | CNAME 최상위 도메인 불가 시 |
| ANAME/ALIAS | Root 도메인 지원 DNS에서 사용 | 최상위 도메인 직접 연결 |

### 3.2 커스텀 도메인 설정 UX

```
[셀러 어드민] 설정 > 도메인 관리
    │
    ├─ 현재 서브도메인: brand-name.sellmatecm.com
    │
    └─ 커스텀 도메인 연결
         │
         ▼
[Step 1] 도메인 입력: mybrand.com
[Step 2] DNS 설정 안내 (레지스트라별 설정 가이드 제공)
         - GoDaddy / Namecheap / 가비아 / 후이즈 / Route53 등
[Step 3] DNS 전파 확인 (자동 체크, 최대 24시간)
[Step 4] SSL 인증서 자동 발급 (Let's Encrypt)
[Step 5] 커스텀 도메인 활성화 완료
```

### 3.3 서브도메인 → 커스텀 도메인 전환 시 처리

- 기존 서브도메인(`brand-name.sellmatecm.com`)은 커스텀 도메인으로 **301 영구 리디렉션** 처리
- SEO 링크 권한(Link Equity) 유지
- 기존 서브도메인 URL은 6개월 후 자동 비활성화 (셀러에게 사전 안내)

---

## 4. 리버스 프록시 설계

### 4.1 아키텍처 개요

```
[인터넷]
    │
    ▼
[CDN / DDoS 방어 레이어]
(CloudFront 또는 Cloudflare)
    │
    ▼
[셀메이트CM 리버스 프록시]
(Nginx / Traefik / AWS ALB)
    │ 도메인 기반 라우팅
    ├─ brand-name.sellmatecm.com → 셀러 brand-name 스토어 컨테이너
    ├─ mybrand.com → (커스텀 도메인 매핑 테이블 조회) → 셀러 스토어
    └─ admin.sellmatecm.com → 운영자 어드민
    │
    ▼
[스토어 렌더링 엔진]
(Next.js App Router, 멀티테넌트 SSR)
    │
    ▼
[백엔드 API]
(FastAPI, schema-per-tenant DB 격리)
```

### 4.2 도메인 라우팅 로직

```python
# 리버스 프록시 라우팅 규칙 (의사 코드)
def route_request(host: str) -> TenantContext:
    # 1. 서브도메인 직접 파싱
    if host.endswith(".sellmatecm.com"):
        seller_id = host.replace(".sellmatecm.com", "")
        return TenantContext(seller_id=seller_id)

    # 2. 커스텀 도메인 → DB 조회
    tenant = CustomDomainMapping.get(host)
    if tenant:
        return TenantContext(seller_id=tenant.seller_id)

    # 3. 알 수 없는 도메인
    raise DomainNotFoundError(host)
```

### 4.3 URL Path 리디렉션 금지 원칙

`sellmatecm.com/store/{셀러ID}` 형태의 path 기반 라우팅은 **금지**한다.

**이유:**
- 셀러 도메인 독립성 보장: 각 셀러는 자신만의 독립 URL 공간을 가짐
- SEO 독립성: 셀러 스토어의 검색 엔진 순위가 sellmatecm.com 도메인 권한에 종속되지 않음
- 브랜딩: `mybrand.com` 또는 `mybrand.sellmatecm.com`으로 고객에게 독립 브랜드로 인식
- 보안 격리: 셀러 간 쿠키·세션 격리가 도메인 레벨에서 자동으로 보장됨

---

## 5. SSL 인증서 관리

| 항목 | 설계 |
|------|------|
| 서브도메인 | Wildcard 인증서 (`*.sellmatecm.com`) — 자동 갱신 |
| 커스텀 도메인 | Let's Encrypt 개별 인증서 — 자동 발급·갱신 (certbot/ACME) |
| 갱신 실패 처리 | 30일 전 경고 → 10일 전 셀러 알림 → 만료 시 사이트 경고 배너 |
| 와일드카드 서브도메인 갱신 | DNS-01 Challenge 방식 (Route53 또는 Cloudflare DNS API 활용) |

---

## 6. 멀티테넌시 데이터 격리

| 격리 레벨 | 방식 |
|---------|------|
| DB | Schema-per-tenant (PostgreSQL 스키마 분리) |
| 파일/이미지 | S3 prefix 기반 격리 (`/{seller_id}/...`) |
| 캐시 | Redis key namespace 분리 (`{seller_id}:...`) |
| 세션/쿠키 | 도메인 기반 자동 격리 |
| API | `X-Tenant-ID` 헤더 또는 도메인 기반 테넌트 컨텍스트 자동 주입 |

---

## 7. 성공 지표 (KPI)

| 지표 | 목표값 |
|------|--------|
| 서브도메인 생성 소요 시간 | ≤ 5초 (가입 완료 직후) |
| 커스텀 도메인 활성화 소요 시간 | DNS 전파 완료 후 ≤ 5분 |
| SSL 발급 성공률 | ≥ 99.9% |
| 도메인 라우팅 응답 시간 | ≤ 50ms (p95) |
