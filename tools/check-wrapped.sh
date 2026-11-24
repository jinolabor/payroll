#!/usr/bin/env bash
# index.html 이 TEAM JINO 로그인 포장본인지 검사한다. 포장본이면 0, 아니면 1.
# 사용: tools/check-wrapped.sh [파일]   (파일을 생략하면 index.html)
f="${1:-index.html}"
[ -f "$f" ] || { echo "파일이 없습니다: $f"; exit 1; }
# 포장본에만 있는 것: 열쇠 파일 주소, 암호화된 본문
grep -q 'var KEY_URL=' "$f" || { echo "로그인 화면(열쇠 파일 확인)이 없습니다."; exit 1; }
grep -q 'PAYLOAD="' "$f"    || { echo "암호화된 본문(PAYLOAD)이 없습니다."; exit 1; }
# 원본에만 있는 것: 잠금 없이 그대로 읽히는 프로그램 코드
if grep -q 'window.ACCESS_GATE' "$f"; then echo "잠금 없는 프로그램 원본이 들어 있습니다."; exit 1; fi
echo "확인: 로그인 포장본입니다."
