# 릴리스와 자동 배포

이 저장소는 **npm은 Changesets**, **Python은 release-please**로 관리한다.

## Node / npm 패키지

- 위치: `packages/*`
- 버전 관리: Changesets
- 배포 workflow 파일: `.github/workflows/release-npm.yml`
- 실제 publish 시점: **Version Packages PR을 merge한 뒤 `main`에 push가 발생했을 때**
- 기본 규칙: 패키지 버전을 직접 손으로 올리지 말고 `.changeset/*.md` 파일을 추가한다.

### 흐름

1. 기능 PR에서 `.changeset/*.md` 추가
2. PR merge
3. Changesets가 Version Packages PR 생성
4. Version Packages PR merge
5. GitHub Actions가 변경된 npm 패키지만 publish

## Python 패키지

- 위치: `python-packages/*`
- 버전 관리: release-please
- 배포 workflow 파일: `.github/workflows/release-python.yml`
- 실제 publish 시점: **release-please가 `release_created=true`를 만든 run**
- 현재 상태: 실제 Python 패키지가 없어 scaffold only

## Trusted publishing 원칙

- npm과 PyPI 모두 OIDC trusted publishing을 우선 사용한다.
- 장기 토큰(`NPM_TOKEN`, `PYPI_API_TOKEN`)은 fallback이 아니면 만들지 않는다.
- npm trusted publisher 등록 시 workflow filename은 `release-npm.yml`이다.
- PyPI trusted publisher 등록 시 workflow filename은 `release-python.yml`이다.

## Maintainer 확인 명령

```bash
npm install
npm run ci
```
