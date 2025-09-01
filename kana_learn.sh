#!/bin/bash

# Colors for better visual appeal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to display colorful header
show_header() {
  clear
  echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║     ${WHITE}Japanese Kana Learning Tool${CYAN}        ║${NC}"
  echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
  echo ""
}

# Function to display hiragana chart
show_hiragana() {
  echo -e "${YELLOW}=== HIRAGANA CHART ===${NC}"
  echo -e "${GREEN}Basic Characters:${NC}"
  echo "あ a   い i   う u   え e   お o"
  echo "か ka  き ki  く ku  け ke  こ ko"
  echo "が ga  ぎ gi  ぐ gu  げ ge  ご go"
  echo "さ sa  し shi す su  せ se  そ so"
  echo "ざ za  じ ji  ず zu  ぜ ze  ぞ zo"
  echo "た ta  ち chi つ tsu て te  と to"
  echo "だ da  ぢ ji  づ zu  で de  ど do"
  echo "な na  に ni  ぬ nu  ね ne  の no"
  echo "は ha  ひ hi  ふ fu  へ he  ほ ho"
  echo "ば ba  び bi  ぶ bu  べ be  ぼ bo"
  echo "ぱ pa  ぴ pi  ぷ pu  ぺ pe  ぽ po"
  echo "ま ma  み mi  む mu  め me  も mo"
  echo "や ya        ゆ yu        よ yo"
  echo "ら ra  り ri  る ru  れ re  ろ ro"
  echo "わ wa  を wo  ん n/m"
  echo ""
  echo -e "${GREEN}Combinations (Yōon):${NC}"
  echo "きゃ kya きゅ kyu きょ kyo   しゃ sha しゅ shu しょ sho"
  echo "ぎゃ gya ぎゅ gyu ぎょ gyo   じゃ ja  じゅ ju  じょ jo"
  echo "ちゃ cha ちゅ chu ちょ cho   にゃ nya にゅ nyu にょ nyo"
  echo "ひゃ hya ひゅ hyu ひょ hyo   みゃ mya みゅ myu みょ myo"
  echo "びゃ bya びゅ byu びょ byo   りゃ rya りゅ ryu りょ ryo"
  echo "ぴゃ pya ぴゅ pyu ぴょ pyo"
}

# Function to display katakana chart
show_katakana() {
  echo -e "${YELLOW}=== KATAKANA CHART ===${NC}"
  echo -e "${GREEN}Basic Characters:${NC}"
  echo "ア a   イ i   ウ u   エ e   オ o"
  echo "カ ka  キ ki  ク ku  ケ ke  コ ko"
  echo "ガ ga  ギ gi  グ gu  ゲ ge  ゴ go"
  echo "サ sa  シ shi ス su  セ se  ソ so"
  echo "ザ za  ジ ji  ズ zu  ゼ ze  ゾ zo"
  echo "タ ta  チ chi ツ tsu テ te  ト to"
  echo "ダ da  ヂ ji  ヅ zu  デ de  ド do"
  echo "ナ na  ニ ni  ヌ nu  ネ ne  ノ no"
  echo "ハ ha  ヒ hi  フ fu  ヘ he  ホ ho"
  echo "バ ba  ビ bi  ブ bu  ベ be  ボ bo"
  echo "パ pa  ピ pi  プ pu  ペ pe  ポ po"
  echo "マ ma  ミ mi  ム mu  メ me  モ mo"
  echo "ヤ ya        ユ yu        ヨ yo"
  echo "ラ ra  リ ri  ル ru  レ re  ロ ro"
  echo "ワ wa  ヲ wo  ン n/m"
  echo ""
  echo -e "${GREEN}Combinations (Yōon):${NC}"
  echo "キャ kya キュ kyu キョ kyo   シャ sha シュ shu ショ sho"
  echo "ギャ gya ギュ gyu ギョ gyo   ジャ ja  ジュ ju  ジョ jo"
  echo "チャ cha チュ chu チョ cho   ニャ nya ニュ nyu ニョ nyo"
  echo "ヒャ hya ヒュ hyu ヒョ hyo   ミャ mya ミュ myu ミョ myo"
  echo "ビャ bya ビュ byu ビョ byo   リャ rya リュ ryu リョ ryo"
  echo "ピャ pya ピュ pyu ピョ pyo"
}

# Function for quiz mode
quiz_mode() {
  # Arrays for quiz questions (hiragana)
  hiragana_chars=("あ" "か" "さ" "た" "な" "は" "ま" "や" "ら" "わ" "が" "ざ" "だ" "ば" "ぱ")
  hiragana_sounds=("a" "ka" "sa" "ta" "na" "ha" "ma" "ya" "ra" "wa" "ga" "za" "da" "ba" "pa")

  score=0
  total_questions=5

  echo -e "${YELLOW}=== HIRAGANA QUIZ MODE ===${NC}"
  echo "I'll show you $total_questions hiragana characters. Type the romanized sound!"
  echo ""

  for ((i = 1; i <= total_questions; i++)); do
    # Pick random character
    index=$((RANDOM % ${#hiragana_chars[@]}))
    char=${hiragana_chars[$index]}
    correct_answer=${hiragana_sounds[$index]}

    echo -e "Question $i/$total_questions: What sound does ${MAGENTA}$char${NC} make?"
    read -p "Your answer: " user_answer

    if [[ "${user_answer,,}" == "$correct_answer" ]]; then
      echo -e "${GREEN}✓ Correct!${NC}"
      ((score++))
    else
      echo -e "${RED}✗ Wrong. The correct answer is: $correct_answer${NC}"
    fi
    echo ""
  done

  echo -e "${CYAN}Quiz Results: $score/$total_questions${NC}"
  if [ $score -eq $total_questions ]; then
    echo -e "${GREEN}Perfect! You're a kana master! 🎉${NC}"
  elif [ $score -gt $((total_questions / 2)) ]; then
    echo -e "${YELLOW}Good job! Keep practicing! 👍${NC}"
  else
    echo -e "${RED}Keep studying! You'll get better! 📚${NC}"
  fi
}

# Function to save charts to file
save_charts() {
  filename="kana_charts_$(date +%Y%m%d_%H%M%S).txt"

  {
    echo "Japanese Kana Charts - Generated on $(date)"
    echo "=========================================="
    echo ""
    show_hiragana
    echo ""
    echo ""
    show_katakana
  } >"$filename"

  echo -e "${GREEN}Charts saved to: $filename${NC}"
}

# Function to show learning tips
show_tips() {
  echo -e "${YELLOW}=== LEARNING TIPS ===${NC}"
  echo -e "${CYAN}1. Practice Order:${NC} Learn hiragana first, then katakana"
  echo -e "${CYAN}2. Group Learning:${NC} Study characters by vowel groups (a, i, u, e, o)"
  echo -e "${CYAN}3. Daily Practice:${NC} Spend 15-20 minutes daily reviewing"
  echo -e "${CYAN}4. Mnemonics:${NC} Create memory aids (あ looks like 'a' person bowing)"
  echo -e "${CYAN}5. Writing Practice:${NC} Write each character multiple times"
  echo -e "${CYAN}6. Real Usage:${NC} Try reading simple Japanese text"
  echo -e "${CYAN}7. Spaced Repetition:${NC} Review difficult characters more frequently"
  echo ""
  echo -e "${MAGENTA}Remember:${NC} Consistency is key! がんばって！(Ganbatte! - Good luck!)"
}

# Function for stroke order info
stroke_order_info() {
  echo -e "${YELLOW}=== STROKE ORDER BASICS ===${NC}"
  echo -e "${CYAN}General Rules:${NC}"
  echo "• Top to bottom (上から下へ)"
  echo "• Left to right (左から右へ)"
  echo "• Horizontal before vertical when crossing"
  echo "• Center before sides in symmetrical characters"
  echo "• Enclosing strokes before enclosed strokes"
  echo ""
  echo -e "${GREEN}Examples:${NC}"
  echo "あ: 3 strokes - curve, horizontal, final stroke"
  echo "か: 3 strokes - horizontal, vertical+hook, small stroke"
  echo "さ: 3 strokes - horizontal, curve, final horizontal"
  echo ""
  echo -e "${MAGENTA}Tip:${NC} Proper stroke order helps with character recognition and speed!"
}

# Main menu function
show_menu() {
  echo -e "${WHITE}Choose an option:${NC}"
  echo -e "${CYAN}1)${NC} Hiragana Chart"
  echo -e "${CYAN}2)${NC} Katakana Chart"
  echo -e "${CYAN}3)${NC} Both Charts"
  echo -e "${CYAN}4)${NC} Quiz Mode (Hiragana)"
  echo -e "${CYAN}5)${NC} Learning Tips"
  echo -e "${CYAN}6)${NC} Stroke Order Info"
  echo -e "${CYAN}7)${NC} Save Charts to File"
  echo -e "${CYAN}8)${NC} Clear Screen"
  echo -e "${CYAN}9)${NC} Quit"
  echo ""
}

# Main program loop
main() {
  while true; do
    show_header
    show_menu

    read -p "Please enter your choice (1-9): " choice
    echo ""

    case $choice in
    1)
      show_hiragana
      echo ""
      read -p "Press Enter to continue..."
      ;;
    2)
      show_katakana
      echo ""
      read -p "Press Enter to continue..."
      ;;
    3)
      show_hiragana
      echo ""
      echo ""
      show_katakana
      echo ""
      read -p "Press Enter to continue..."
      ;;
    4)
      quiz_mode
      echo ""
      read -p "Press Enter to continue..."
      ;;
    5)
      show_tips
      echo ""
      read -p "Press Enter to continue..."
      ;;
    6)
      stroke_order_info
      echo ""
      read -p "Press Enter to continue..."
      ;;
    7)
      save_charts
      echo ""
      read -p "Press Enter to continue..."
      ;;
    8)
      clear
      ;;
    9)
      echo -e "${GREEN}ありがとうございました！(Arigatou gozaimashita! - Thank you!)${NC}"
      echo -e "${YELLOW}がんばって！(Ganbatte! - Good luck with your studies!)${NC}"
      break
      ;;
    *)
      echo -e "${RED}Invalid option. Please choose 1-9.${NC}"
      sleep 2
      ;;
    esac
  done
}

# Run the main program
main
