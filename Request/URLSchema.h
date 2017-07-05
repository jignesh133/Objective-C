
#ifndef URLSchema_h
#define URLSchema_h
//192.168.1.145
static NSString *kBASE_URL                   =@"http://162.250.121.171:3011/"; // live
//static NSString *kBASE_URL                   =@"http://192.168.1.149:9000/"; // local

static NSString *kGoogleULR                  =@"https://docs.google.com/gview?embedded=true&url=";
static NSString *kBASE_URL_GOOGLE            =@"https://www.googleapis.com/language/translate/v2?key=";
static NSString *KGOOGLEKEY                  =@"AIzaSyBIzJszn3BtH4TgDO1OAKuFMSp-9R-TSMs";
static NSString *KINTERNET_CONNECTION        =@"Please check your internet connection or try again later";
static NSString *kLogin                      =@"auth/local";
static NSString *kSocialLogin                =@"api/user/signin";
static NSString *kRegister                   =@"api/user/register_user";
static NSString *kUser                       =@"";
static NSString *kEmailLogin                 =@"";
static NSString *kForgotPassword             =@"api/user/forgotpassword";
static NSString *kUploadUserAvatar           =@"api/user/upload/avatar/";
static NSString *kGetImage                   =@"api/image/get/";
static NSString *kChangePassword             =@"api/user/updatepassword";
static NSString *kUpdateAccount              =@"api/query/execute/putpost/User";
static NSString *kUpdateAccountAvatar        =@"api/image/upload";
static NSString *kUpdateToken                =@"api/query/execute/putpost/User";
static NSString *kgetUser                    =@"api/user/getuser/settings";
//Category
static NSString *kGetCategory                =@"api/category/get_catagories";
static NSString *kCreateCategory             =@"api/query/execute/putpost/Category";

//Chat
static NSString *kSendMessage                =@"api/query/Chat";
static NSString *kGetChat                    =@"api/query/execute/conditions/Chat";
static NSString *kMakeRead                   =@"api/chat/make/read";
static NSString *kDeleteMsg                  =@"api/chat/delete/messages";
static NSString *KNotLoggedInUser            =@"/api/query/execute/conditions/User";

//foram
static NSString *KForum                      =@"api/query/execute/conditions/Forum";

//Deck
static NSString *kGetDeck                    =@"api/query/execute/conditions/Deck";
static NSString *kAddDeck                    =@"api/deck/adddata";

//Forum
static NSString *kPostForum                  =@"api/query/Forum";
static NSString *kGetForum                   =@"api/query/execute/conditions/Forum";

//Glossary
static NSString *kAddGlossary                =@"api/glossary/add/words";
static NSString *kEditGlossary               =@"api/query/execute/putpost/Glossary";
static NSString *kDeleteGlossary             =@"api/query/soft/Glossary/";

//Logs
static NSString *kAppLog                     =@"api/Applog";
static NSString *kStudyLog                   =@"api/query/Studylog";
static NSString *kWordLog                    =@"api/query/WordLog";

//Notification
static NSString *kGetNotification            =@"/api/query/execute/conditions/Notification";

//School Info
static NSString *kGetAllTeacher              =@"api/query/execute/conditions/User";
static NSString *kGetAllSchools              =@"api/query/School";

//Static Content
static NSString *kStaticContent              =@"api/query/execute/conditions/StaticContent";

//Tips
static NSString *kGetAllTips                 =@"api/query/Tips/";
static NSString *kGetAllMessagesCount        =@"/api/query/execute/conditions/Chat";

//Others
static NSString *kImgUpload                  =@"/api/image/upload";

//Get Getdictionary for
static NSString *kGetdictionary              =@"/api/dictionary/getdictionary";

// Post Feedback
static NSString *kSendfeedback               =@"api/user/send_feedback";

// Post Add Goal
static NSString *kAddGoal                    =@"api/query/Goal";


// stestics
static NSString *kApplog                     =@"api/query/Applog";

//lesson
static NSString *kLessonCondition           =@"/api/query/execute/conditions/Lesson";
static NSString *kLesson                    =@"/api/query/Lesson";
static NSString *Klexin_meaning             =@"/api/dictionary/get_word_result";
static NSString *kUpdateSchool              =@"api/query/execute/putpost/User";
static NSString *kChangeSchool              =@"api/user/change/school";
static NSString *KLastMessage               =@"/api/chat/get/userlist";

//delete category
static NSString *KDeleteCat                 =@"/api/query/soft/Category";
static NSString *KEditCat                   =@"/api/query/execute/putpost/Category";


//delete Sub category
static NSString *KDeleteSubCat              =@"/api/query/soft/Deck";
static NSString *KEditSubCat                =@"/api/query/execute/putpost/Deck";

//delete Flashcard
static NSString *KDeleteFlashCard           =@"/api/query/soft/Glossary";
static NSString *KEditFlashCard             =@"/api/query/execute/putpost/Glossary";

// Flashcard Study
static NSString *KFlashcardStudy            =@"api/query/execute/putpost/FlashcardStudy";


// Flashcard Edit
static NSString *KFlashcardEdit             =@"api/query/execute/putpost/Glossary";

// Metirials
static NSString *KFlashcardStudyList        =@"/api/query/execute/conditions/FlashcardStudy";
static NSString *KStudentMaterial           =@"/api/query/execute/conditions/StudentMaterial";

//Announcement
static NSString *KAnnouncement              =@"api/query/execute/conditions/Notification";
static NSString *kteacherlistannouncement   =@"api/chat/get/teacherlist/announcement";
//Achivements
static NSString *Kachievements              =@"/api/achievements/get/achievement/";
static NSString *KNotificationPut           =@"/api/query/Notification";
static NSString *KDashboardStatistics       =@"api/dashboard/student/dash_data";

//http://162.250.121.171:3011/api/query/soft/Category/58d35487f2e3600e26c4d87f

#define GOOGLE_KEY                          @"661008995983-cc0mar8larjce541bhra5k7tq3jqcis5.apps.googleusercontent.com";

static NSString *KAboutUs                   =@"https://www.google.co.in";
static NSString *KHelp                      =@"https://www.google.co.in";

static NSString *Kplease_wait               =@"Please wait..";
static NSString *KSm_Wrong                  =@"Something went wrong..";

static NSString *KSaveNotificationSetting   =@"api/query/execute/putpost/NotificationSetting";
static NSString *KNotificationSetting       =@"/api/query/execute/conditions/NotificationSetting";

static NSString *KTotalunreadannouncements  =@"/api/query/execute/conditions/Notification";
static NSString *KMakeAnnouncementRead      =@"api/notification/make/read";
static NSString *KTotalunreadChats          =@"api/query/execute/conditions/Chat";

static NSString *kMessageMakeRead           =@"/api/chat/make/read";

static NSString *kGetschedules              =@"api/class/get/schedules";

//LeitnerLog
static NSString *LeitnerLog                 =@"api/query/execute/conditions/LeitnerLog";
static NSString *LeitnerAddEditLog          =@"api/query/execute/putpost/LeitnerLog";

static NSString * UploadGlossary            =@"api/image/upload";


#endif /* URLSchema_h */

