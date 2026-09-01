# settings

개발환경 세팅을 저장해두고 SSOT로 활용하는 repository 입니다.

## usage

```bash
curl -L https://settings.woohm404.com/init.sh | bash
```

기존 설정 파일은 덮어쓰기 전에 `.bak`으로 백업되고, 다운로드가 실패하면 기존 파일을 그대로 둡니다.

## Programs

`brew bundle`로 자동 설치되는 것들:

| | |
|---|---|
| [`zed`](https://zed.dev) | 에디터. 내장 터미널을 주 터미널로 사용 |
| [`rectangle`](https://rectangleapp.com) | 창 관리 |
| [`orbstack`](https://orbstack.dev) | 컨테이너 / VM |
| [`arc`](https://arc.net) | 브라우저 |
| [`gh`](https://cli.github.com) | GitHub CLI |
| `ffmpeg`, `poppler` | 미디어 / PDF 처리 |
| [`monaspace`](https://monaspace.githubnext.com) | 폰트 (zed 설정이 참조) |

수동 설치가 필요한 것들:

- [`orca`](https://github.com/stablyai/orca/releases) — homebrew cask가 없어 직접 다운로드

## 관리되는 설정

- `settings/zed/` — 에디터 설정, 키맵, 스니펫
- `settings/zsh/.zshrc` — 셸 설정
- `settings/rectangle/` — 창 관리 단축키
- `settings/homebrew/Brewfile` — 설치 패키지 목록
- `scripts/macos.sh` — macOS 시스템 설정 (`defaults write`)
