
const String APP_NAME = '차근차근';

// API_
const String BASE_URL                 = '106.251.70.71:30012'; // TEST SERVER : stepbystep.megaworks.ai/'106.251.70.71:30012'
const String API_PREFIX               = 'http://$BASE_URL/ws';
const String API_URL_LOGIN            = '$API_PREFIX/public/user/login';
const String API_URL_USER_INSERT      = '$API_PREFIX/public/user/insert';
const String API_URL_USER_DUPLICATE   = '$API_PREFIX/private/user/duplicateId';
const String API_URL_USER_GET         = '$API_PREFIX/private/user/get';
const String API_URL_USER_FIND_ID     = '$API_PREFIX/private/user/findId';
const String API_URL_USER_FIND_PASS   = '$API_PREFIX/private/user/findPwd';
const String API_URL_ACCIDENT_INFO    = '$API_PREFIX/private/accident/info/insert';
const String API_URL_ACCIDENT_GET     = '$API_PREFIX/private/accident/get';
const String API_URL_CHAT_PTSD_TEST   = '$API_PREFIX/private/ptsd/test';
const String API_URL_CHAT_IESRK_TEST  = '$API_PREFIX/private/iesrk/test';
const String API_URL_IESRK_LIST       = '$API_PREFIX/private/iesrk/get';
const String API_URL_PTSD_LIST        = '$API_PREFIX/private/ptsd/get';
const String API_URL_USER_UPDATE      = '$API_PREFIX/private/user/update';
const String API_URL_USER_DELETE      = '$API_PREFIX/private/user/delete';
const String API_URL_USER_DELETE_TEMP = '$API_PREFIX/private/user/deleteTempUser';


const String DIALOG_DESCRIPTION = '• 외상관련 증상을 자기보고식으로 작성하는 척도인 사건 충격척도(Impact of Event Scale : 이하 IES) 라는 도구를 개발하였고 이 척도는 현재까지 전세계적으로 가장 널리 사용되고 있습니다.\n\n• IES는 가장 흔하게 보고된 외상과 관련된 심리적 반응 양상들 중 침습 및 회피 증상을 확인하기 위해 고안되었습니다.';

// MESSAGE_
const String MESSAGE_LOGIN_FALSE          = '로그인 실패';
const String MESSAGE_CHECK_ID_PASS        = '아이디 또는 비밀번호를 확인하세요.';
const String MESSAGE_SERVER_ERROR_DEFAULT = '서버 오류 발생 재시도 바랍니다.';
const String MESSAGE_NOT_EXIST_RESULT     = '요청한 파라미터의 결과 데이터가 존재하지 않습니다.';
const String MESSAGE_ERROR_CONNECT_SERVER = '서버 연결 오류입니다. 재시도 바랍니다.';
const String MESSAGE_AVAILABLE_ID         = '사용 가능한 ID입니다.';
const String MESSAGE_INSERT_FAILURE       = '입력되지 못했습니다. 다시 시도바랍니다.';
const String MESSAGE_UPDATE_FAILURE       = '회원 정보 변경이 실패 했습니다. 다시 시도바랍니다.';


// 영상 URL
// URL_
const String URL_TO_LAUNCH_YOUTUBE_VR     = 'https://youtu.be/tydhvV_iXM8';
const String URL_TO_LAUNCH_YOUTUBE_STRESS = 'https://www.youtube.com/watch?v=3d8x6quzvqI';


// id 찾기
// FIND_ID_
const String FIND_ID_DESCRIPTION   = '$APP_NAME에 가입했던 이름, 이메일을 입력해주세요.\n아이디를 메일로 보내드립니다.';
const String FIND_ID_NOT_FOUND_MSG = '아이디를 찾지 못했습니다. \n이메일,이름 확인 후 재시도 바랍니다.';


// password 찾기
// FIND_PASS_
const String FIND_PASS_DESCRIPTION  = '$APP_NAME에 가입했던 아이디,이름,이메일을 입력해주세요.\n임시 비밀번호를 메일로 보내드립니다.';
const String FIND_PASS_UNKNOWN_USER = '사용자를 확인 할 수 없습니다. 아이디, 이름, 메일 정보를 확인 해 주세요';
const String FIND_PASS_ID_NOT_MATCH = '입력 정보를 확인 해 주세요';

const String FIND_COMPLETE_MAIL_MSG = '메일이 전송되었습니다. 확인바랍니다.';


// 교통사고 PTSD 바로알기 - [심리교육]
// PSYCHOLOGICAL_
const String PSYCHOLOGICAL_DESCRIPTION_DEFINE = '• 인지 행동치료의 하나의 요소로, 질환에 대한 이해를 높임으로써 자기 반응을 잘 이해하게 하는 것';
const String PSYCHOLOGICAL_DESCRIPTION_WAY    = '• 환자가 겪고 있는 증상이나 질병의 원인, 경과, 치료방법에 대한 지식 습득 및 대처 방법 학습\n• 신체적 외상 이후 겪을 수 있는 심리적 외상에 대한 정보 제공';


// 교통사고 PTSD 바로알기 - [PTSD 알아보기]
// LEARN_
const String LEARN_DESCRIPTION_DEFINE  = '• 교통사고와 같은 심각한 외상을 겪은 후에 나타는 불안 장애를 말함\n\n• 교통사고를 경험한 개인은 외상 이후 겪을 수 있는 정신건강문제인 외상 후 스트레스 장애 발병률이 10~50%인 고위험군 임\n\n•  심한 외상적 충격에서 스스로를 보호하기 위한 재경험, 과각성, 회피, 마비 등의 반응에 따른 것으로 보임';
const String LEARN_DESCRIPTION_SYMPTOM = '• 꿈이나 반복되는 생각을 통해 외상을 재 경험함\n\n• 외상과 연관되는 상황을 피하려고 하거나 무감각해짐\n\n• 자율신경계가 과각성되어 쉽게 놀라거나 집중력 저하, 수면장애, 짜증 증가 등이 있음';
const String LEARN_DESCRIPTION_ACTION  = '• 교통사고 이후 환자들에게 조기 개입을 통하여 외상 후 스트레스 장애의 충격을 최소화 하기 위한 진단 서비스의 제공이 필요함';


// 교통사고 PTSD 치료 - [목적]
// PURPOSE_
const String PURPOSE_DESCRIPTION =
    '교통사고 후 생존자들의 심리적 반응과 충족되어야 하는 심리적 요구 해결\n\n'+
        '• 자신의 기본적인 생존을 위한 걱정\n'+
        '• 사랑하는 사람, 가지고 있는 의미있는 소유물에 대한 상실감\n'+
        '• 자신과 사랑하는 사람들의 안전에 대한 걱정과 불안\n'+
        '• 악몽, 재난 상황의 재경험으로 인한 수면장애\n'+
        '• 이주와 그에 따른 고립이나 악화된 주거환경에 대한 염려\n'+
        '• 재난충격 및 상실과 관련된 고통스러운 감정의 환기 및 정상화\n'+
        '• 사회적 지지';
const String PURPOSE_PROVIDE_TREATMENT = '• PTSD 치료는 약물치료와 정신치료를 포함한 심리사회적 개입으로 구분\n\n'+ '• 본 앱은 2가지 심리사회적 개입을 제공함';


// 교통사고 PTSD 치료 - [안정화 기법]
// STABILIZE_
const String STABILIZE_DESCRIPTION_DEFINE = '사고 이후 과민반응된 사용자를 안정시키기 위한 방법(보건복지부 정신건강기술개발사업으로 개발, 국립트라우마센터에서 보급)';
const String STABILIZE_DESCRIPTION_USE    = '• 교통사고 상황과 관련하여 부정적인 기억이 떠오를 때\n• 현실감이 없어질 때\n• 불안감이 조절되지 않을 때\n  사용할 것을 권함';
const String STABILIZE_DESCRIPTION_TO_FOLLOW =
        '• 우선 심호흡을 5번 해보겠습니다.\n 심호흡은 숨을 코로 들이마시고, 입으로 ‘후’ 소리를 내면서 풍선을 불듯이 천천히 끝까지 내쉬는 겁니다.\n\n'+
        '• 교통사고가 일어난 것은 언제인가요? 오늘이 몇 년 몇 월 몇 일 인가요?\n\n'+
        '• 자, 이제 이 치료실에 뭐가 보이는지 둘러보시고 보이는 3가지를 말해주세요. (ex: 책상, 책, 컴퓨터, 의자, 마우스)\n\n'+
        '• 좋습니다. 이번에는 눈을 감고 지금 뭐가 들리는지 3가지를 말해주세요. (ex: 숨소리, 컴퓨터 소리, 시계소리)\n\n'+
        '• 네, 좋습니다. 이번에는 다시 눈을 감고 몸의 느낌에 집중을 해보도록 하겠습니다.\n발바닥을 바닥에 붙이고, 발이 땅에 닿아있는 느낌에 집중하세요. 발을 들었다가 ‘쿵’ 내려놓아 보세요. 다시 발바닥에서 느껴지는 단단한 바닥을 느껴보세요. 자, 똑같이 3번 반복하도록 하겠습니다.\n\n'+
        '마지막으로 심호흡을 다시 5번 하겠습니다.\n';
const String STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_1 = '여러분이 긴장을 하게 되면 자신도 모르게 \'후~\'하고 한숨을 내쉬게 되지요.\n 그것이 바로 심호흡이에요. 심호흡은 숨을 코로 들이미시고, 입으로 \'후~\' 소리를 내면서 풍선을 불듯이 천천히 끝까지 내쉬는 거예요. 가슴에서 숨이 빠져나가는 느낌에 집중하면서 천천히 내쉬세요.';
const String STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_2 = '복식호흡은 숨을 들이쉬면서 아랫배가 풍선처럼 부풀어 오르게 하고, 숨을 내쉴 때 꺼지게 하는 거예요.\n이때는 코로만 숨을 쉬세요. 천천히 깊게, 숨을 아랫배까지 내려보낸다고 상상해 보세요.\n천천히 일정하게 숨을 들이쉬고 내쉬면서 아랫배가 묵직해지는 느낌에 집중하세요.';
const String STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_3 = '착지법은 땅에 발을 딛고 있는 것을 느끼면서 \"지금 여기\"로 돌아오는 거예요.\n발바닥을 바닥에 붙이고 발이 땅에 닿아있는 느낌에 집중하세요.\n발뒤꿈치에 지긋이 힘을 주면서 단단한 바닥을 느껴보세요.';
const String STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_4 = '나비 포옹법은 갑자기 긴장이 되어 가슴이 두근대거나, 괴로운 장면이 떠오를 때, 그것이 빨리 지나가게끔 자신의 몸을 좌우로 두드려 주고 셀프로 토닥토닥 하면서 스스로 안심을 시켜 주는 방법이에요.\n두 팔을 가슴 위에서 교차시킨 상태에서 양측 팔뚝에 양 손을 두고 나비가 날갯짓하듯이 좌우를 번갈아 살짝살짝 10~15번 정도 두드리면 돼요.';


// 교통사고 PTSD 치료 - [스트레스 버킷 모델]
// BUCKET_
const String BUCKET_DESCRIPTION_DEFINE = '• 조절되지 않는 스트레스는 PTSD를 만성화하게 함에 따라 가상현실 기술을 통해 적절한 스트레스를 관리하고자 함';
const String BUCKET_DESCRIPTION_INTRODUCTION = '• 가상현실 기술로 사고 상황에 노출되게 함으로써 PTSD를 이겨내는데 도움이 되는 치료\n\n''• 교통사고 당시의 상황에 대한 노출로 감정적 내성을 길러줌으로써 PTSD 치료 가능\n\n• 치료를 위한 가상현실이므로 위험 상황에서 안전하게 탈출가능';


// 챗봇 인사 말
// COMMON_
const String COMMON_GREETINGS_HELLO = '안녕하세요? 반갑습니다.';
const String COMMON_GREETINGS_START = '자, 그럼 시작할게요.';


// 교통사고 IES-R-K 검사
// IESRK_
const String IESRK_GREETINGS_STEP_1 = '저희 어플에서 제공하는 진단 툴은 정신건강의학과 전문가들이 임상에서 진단을 내리기 위하여 사용하는 MINI (한국판 정신 질환 간이 면접법, Korean Version of mini International neuropsychiatric interview)와 CAPS(임상가를 위한 외상 후 스트레스 척도, Clinician-Administered PTSD scale)를 변형한 것입니다.';
const String IESRK_GREETINGS_STEP_2 = '제가 여쭈어보는 질문에 답을 하시면 최종적으로 진단을 내려 줍니다.';
const String IESRK_GREETINGS_STEP_3 = '시작하기에 앞서, 어플에서 내려진 진단이 의학적인 질환 유무를 확정하는 것은 아니며, 진단은 반드시 전문의를 통한 검사와 면담결과로 이루어짐을 안내해 드립니다.';


// 교통사고 PTSD 검사
// PTSD_
 const String PTSD_GREETINGS_STEP_1 = '저희 어플에서 제공하는 진단 툴은 정신건강의학과 전문가들이 임상에서 진단을 내리기 위하여 사용하는 MINI (한국판 정신 질환 간이 면접법, Korean Version of mini International neuropsychiatric interview)와 CAPS(임상가를 위한 외상 후 스트레스 척도, Clinician-Administered PTSD scale)를 변형한 것입니다.';
 const String PTSD_GREETINGS_STEP_2 = '제가 여쭈어보는 질문에 답을 하시면 최종적으로 진단을 내려 줍니다.';
 const String PTSD_GREETINGS_STEP_3 = '시작하기에 앞서, 어플에서 내려진 진단이 의학적인 질환 유무를 확정하는 것은 아니며, 진단은 반드시 전문의를 통한 검사와 면담결과로 이루어짐을 안내해 드립니다.';


// IES-R-K 결과 화면
// RESULT_IESRK_
const String RESULT_IESRK_GOOD     = '• 분석 결과 아주 정상입니다. 최소 한달에 한번씩 우리 앱을 통해 꾸준히 관리를 해 주시기 바랍니다.';
const String RESULT_IESRK_BAD      = '• 분석 결과 PTSD 진단을 추가적으로 진행해 주실 것을 권고 드립니다. 더불어 심리회복에 도움이 되실 만한 우리 앱의 심리 교육 및 안정화 기법을 소개 드립니다.';
const String RESULT_IESRK_VERY_BAD = '• 정신건강의학과에 내원해 주실 것을 권고 드립니다.';
const String RESULT_COMMON         = '• 본 검사가 의학적인 질환 유무를 확정하는 것은 아니며, 진단은 반드시 전문의를 통한 검사와 면담결과로 이루어짐을 안내해 드립니다.';


// PTSD 결과 화면
// RESULT_PTSD_
const String RESULT_PTSD_NORMAL = '• 일상생활에 빨리 복귀하시길 바라며 최소 한달에 한번씩 우리 앱을 통해 꾸준히 관리를 해 주시기 바랍니다.';
const String RESULT_PTSD_BAD    = '• 이후 외상 후 스트레스 추가 검사 실시(의학적 진단 결과 아님) 또는 전문의를 통한 검사와 진료를 통한 정확한 의학적 진단을 받을 것을 권하여 드립니다.';


// Custom Picker 초기 값
abstract class PickerInitial {
 static const int ageInitialVal = 10;
 static const int educationInitialVal = 6;
 static const int familiesInitialVal = 1;
 static const int accidentInitialVal = 1;

 static const String religionInitialVal = '개신교';
 static const String carColorInitialVal = '흰색';
 static const String jobInitialVal      = '관리자';
}

// Custom Picker list 생성 값
abstract class PickerItemList {
 static final ageItemList           = List.generate(90, (i) => i+10);
 static final educationItemList     = List.generate(25, (i) => i+6);
 static final familiesCntItemList   = List.generate(10, (i) => i+1);
 static final accidentSpeedItemList = List.generate(229, (i) => i+1);

 static const List<String> religionItemList = ['개신교','불교', '가톨릭','원불교', '유교', '기타'];
 static const List<String> carColorItemList = ['흰색','회색', '검정','은색', '파랑', '빨강', '갈색/베이지색', '노랑/금색', '기타']; // 사고 평가 차량 색상
 static const List<String> jobItemList      = ['관리자', '전문가 및 관련 종사자', '사무 종사자', '서비스 종사자', '판매 종사자', '농림,어업 종사자', '기능원 관련 종사자', '장치,기계 조작 및 조립 종사자','군인','단순 노무 종사자', '기타']; // 사고 평가 차량 색상
}

// Custom Picker list 생성 값
abstract class GridName {
 static const gender     = '성별';
 static const married    = '결혼';
 static const familyYN   = '동거';
 static const jobYN      = '직업';
 static const religionYN = '종교';

 static const accidentType    = '사고 유형';
 static const carType         = '본인 차량';
 static const opponentCarType = '상대방 차량';
 static const weather         = '날씨';
 static const direction       = '사고 방향';
 static const admissionYN     = '입원';
 static const hurtHeadYN      = '머리';
 static const memoryYN        = '상황';
 static const legalMatterYN   = '법적';
}



