# 설치 방법

## 무엇을 설치할지 먼저 고르기

| 하고 싶은 일 | 같이 설치할 것 |
| --- | --- |
| KBO 경기 결과만 보기 | `kbo-results` |
| 로또 결과만 보기 | `lotto-results` |
| SRT 예매하기 | `k-skill-setup`, `srt-booking` |
| KTX 예매하기 | `k-skill-setup`, `ktx-booking` |
| 서울 지하철 도착정보 보기 | `k-skill-setup`, `seoul-subway-arrival` |
| 전부 설치하기 | `k-skill-setup` + 나머지 전체 |

## 에이전트에게 맡기기

Codex나 Claude Code에 아래 문장을 그대로 붙여 넣으면 된다.

```text
이 레포의 설치 문서를 읽고 k-skill을 설치해줘. 조회형 스킬은 바로 설치하고, credential이 필요한 스킬을 설치하면 k-skill-setup도 같이 설치해. 설치가 끝나면 설치된 스킬과 다음 단계만 짧게 정리해.
```

## 직접 설치

`skills` 설치 명령은 아래 셋 중 하나만 있으면 된다.

```bash
npx --yes skills add <owner/repo> --list
pnpm dlx skills add <owner/repo> --list
bunx skills add <owner/repo> --list
```

원하는 스킬만 설치:

```bash
npx --yes skills add <owner/repo> --skill kbo-results --skill lotto-results
```

credential이 필요한 스킬까지 같이 설치:

```bash
npx --yes skills add <owner/repo> \
  --skill k-skill-setup \
  --skill srt-booking \
  --skill ktx-booking \
  --skill seoul-subway-arrival
```

## 로컬 테스트

현재 디렉터리에서 바로 확인:

```bash
npx --yes skills add . --list
```

유지보수자가 패키지/릴리스 설정까지 같이 검증하려면:

```bash
npm install
npm run ci
```

## 패키지가 없을 때의 기본 동작

스킬 실행에 필요한 Node/Python 패키지가 없으면 다른 방법으로 우회하지 말고 전역 설치를 먼저 시도하는 것을 기본으로 합니다.

### Node 패키지

```bash
npm install -g kbo-game k-lotto
export NODE_PATH="$(npm root -g)"
```

### Python 패키지

```bash
python3 -m pip install SRTrain korail2
```

운영체제 정책이나 권한 때문에 전역 설치가 막히면, 임의의 대체 구현으로 넘어가지 말고 그 차단 사유를 사용자에게 설명한 뒤 다음 설치 단계를 정합니다.

## npx도 없으면

`npx`, `pnpm dlx`, `bunx` 중 아무것도 없으면 먼저 Node.js 계열 런타임을 설치해야 한다.

- `npx`를 쓰려면 Node.js + npm
- `pnpm dlx`를 쓰려면 pnpm
- `bunx`를 쓰려면 Bun

## setup이 필요한 스킬

먼저 `k-skill-setup`을 따라야 하는 스킬:

- `srt-booking`
- `ktx-booking`
- `seoul-subway-arrival`

관련 문서:

- [공통 설정 가이드](setup.md)
- [보안/시크릿 정책](security-and-secrets.md)
