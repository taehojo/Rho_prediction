
require(randomForest) || install.packages("randomForest")
require(verification) || install.packages("verification")
require(ggplot2) || install.packages("ggplot2")
require(pROC) || install.packages("pROC")

library(randomForest)
library(verification)
library(ggplot2)
library(pROC)


setwd("~/Rho_prediction")

#145 set
data_train = read.csv("./ml-result/145-trn.csv", header = TRUE)
data_test = read.csv("./ml-result/145-test.csv", header = TRUE)

#1160 set
#data_train = read.csv("./ml-result/1160-trn.csv", header = TRUE)
#data_test = read.csv("./ml-result/1160-test.csv", header = TRUE)

# cros validation
set.seed(777)
rfcv.res = rfcv(data_train[,c(2:145)], as.factor(data_train[,1]))

# Error Rate
plot(rfcv.res$n.var, rfcv.res$error.cv, log="x",type="o", lwd=2, xlab="Number of Variables", ylab="Error Rate")
lines(rfcv.res$n.var, rfcv.res$error.cv)
title(main="Estimated Error Rate")

print(rfcv.res$error.cv)

#model

#145a
fit.all <- randomForest(as.factor(f0) ~ f1 + f2 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f10 + f11 + f12 + f13 + f14 + f15 + f16 + f17 + f18 + f19 + f20 + f21 + f22 + f23 + f24 + f25 + f26 + f27 + f28 + f29 + f30 + f31 + f32 + f33 + f34 + f35 + f36 + f37 + f38 + f39 + f40 + f41 + f42 + f43 + f44 + f45 + f46 + f47 + f48 + f49 + f50 + f51 + f52 + f53 + f54 + f55 + f56 + f57 + f58 + f59 + f60 + f61 + f62 + f63 + f64 + f65 + f66 + f67 + f68 + f69 + f70 + f71 + f72 + f73 + f74 + f75 + f76 + f77 + f78 + f79 + f80 + f81 + f82 + f83 + f84 + f85 + f86 + f87 + f88 + f89 + f90 + f91 + f92 + f93 + f94 + f95 + f96 + f97 + f99 + f100 + f101 + f102 + f103 + f104 + f105 + f106 + f107 + f108 + f109 + f110 + f111 + f112 + f113 + f114 + f115 + f116 + f117 + f118 + f119 + f120 + f121 + f122 + f123 + f124 + f125 + f126 + f127 + f128 + f129 + f130 + f131 + f132 + f133 + f134 + f135 + f136 + f137 + f138 + f139 + f140 + f141 + f142 + f143 + f144 + f145, data=data_train)

#145b
#fit.all <- randomForest(as.factor(f0) ~ f1+ f2+ f3+ f4+ f5+ f6+ f7+ f8+ f9+ f10+ f11+ f12+ f13+ f14+ f15+ f16+ f17+ f18+ f19+ f20+ f21+ f22+ f23+ f24+ f25+ f26+ f27+ f28+ f29+ f30+ f31+ f32+ f33+ f34+ f35+ f36+ f37+ f38+ f39+ f40+ f41+ f42+ f43+ f44+ f45+ f46+ f47+ f48+ f49+ f50+ f51+ f52+ f53+ f54+ f55+ f56+ f57+ f58+ f59+ f60+ f61+ f62+ f63+ f64+ f65+ f66+ f67+ f68+ f69+ f70+ f71+ f72+ f73+ f74+ f75+ f76+ f77+ f78+ f79+ f80+ f81+ f82+ f83+ f84+ f85+ f86+ f87+ f88+ f89+ f90+ f97+ f99+ f100+ f101+ f102+ f103+ f104+ f105+ f106+ f107+ f108+ f109+ f110+ f111+ f112+ f113+ f114+ f115+ f116+ f117+ f118+ f119+ f120+ f121+ f122+ f123+ f124+ f125+ f126+ f127+ f128+ f129+ f130+ f131+ f132+ f133+ f134+ f135+ f136+ f137+ f138+ f139+ f140+ f141+ f142+ f143+ f144+ f145, data=data_train)

#1160a
#fit.all <- randomForest(as.factor(f0) ~ f1+ f2+ f3+ f4+ f5+ f6+ f7+ f8+ f9+ f10+ f11+ f12+ f13+ f14+ f15+ f16+ f17+ f18+ f19+ f20+ f21+ f22+ f23+ f24+ f25+ f26+ f27+ f28+ f29+ f30+ f31+ f32+ f33+ f34+ f35+ f36+ f37+ f38+ f39+ f40+ f41+ f42+ f43+ f44+ f45+ f46+ f47+ f48+ f49+ f50+ f51+ f52+ f53+ f54+ f55+ f56+ f57+ f58+ f59+ f60+ f61+ f62+ f63+ f64+ f65+ f66+ f67+ f68+ f69+ f70+ f71+ f72+ f73+ f74+ f75+ f76+ f77+ f78+ f79+ f80+ f81+ f82+ f83+ f84+ f85+ f86+ f87+ f88+ f89+ f90+ f91+ f92+ f93+ f94+ f95+ f96+ f97+ f99+ f100+ f101+ f102+ f103+ f104+ f105+ f106+ f107+ f108+ f109+ f110+ f111+ f112+ f113+ f114+ f115+ f116+ f117+ f118+ f119+ f120+ f121+ f122+ f123+ f124+ f125+ f126+ f127+ f128+ f129+ f130+ f131+ f132+ f133+ f134+ f135+ f136+ f137+ f138+ f139+ f140+ f141+ f142+ f143+ f144+ f145+ f146+ f147+ f148+ f149+ f150+ f151+ f152+ f153+ f154+ f155+ f156+ f157+ f158+ f159+ f160+ f161+ f162+ f163+ f164+ f165+ f166+ f167+ f168+ f169+ f170+ f171+ f172+ f173+ f174+ f175+ f176+ f177+ f178+ f179+ f180+ f181+ f182+ f183+ f184+ f185+ f186+ f187+ f188+ f189+ f190+ f191+ f192+ f193+ f194+ f195+ f196+ f197+ f198+ f199+ f200+ f201+ f202+ f203+ f204+ f205+ f206+ f207+ f208+ f209+ f210+ f211+ f212+ f213+ f214+ f215+ f216+ f217+ f218+ f219+ f220+ f221+ f222+ f223+ f224+ f225+ f226+ f227+ f228+ f229+ f230+ f231+ f232+ f233+ f234+ f235+ f236+ f237+ f238+ f239+ f240+ f241+ f242+ f244+ f245+ f246+ f247+ f248+ f249+ f250+ f251+ f252+ f253+ f254+ f255+ f256+ f257+ f258+ f259+ f260+ f261+ f262+ f263+ f264+ f265+ f266+ f267+ f268+ f269+ f270+ f271+ f272+ f273+ f274+ f275+ f276+ f277+ f278+ f279+ f280+ f281+ f282+ f283+ f284+ f285+ f286+ f287+ f288+ f289+ f290+ f291+ f292+ f293+ f294+ f295+ f296+ f297+ f298+ f299+ f300+ f301+ f302+ f303+ f304+ f305+ f306+ f307+ f308+ f309+ f310+ f311+ f312+ f313+ f314+ f315+ f316+ f317+ f318+ f319+ f320+ f321+ f322+ f323+ f324+ f325+ f326+ f327+ f328+ f329+ f330+ f331+ f332+ f333+ f334+ f335+ f336+ f337+ f338+ f339+ f340+ f341+ f342+ f343+ f344+ f345+ f346+ f347+ f348+ f349+ f350+ f351+ f352+ f353+ f354+ f355+ f356+ f357+ f358+ f359+ f360+ f361+ f362+ f363+ f364+ f365+ f366+ f367+ f368+ f369+ f370+ f371+ f372+ f373+ f374+ f375+ f376+ f377+ f378+ f379+ f380+ f381+ f382+ f383+ f384+ f385+ f386+ f387+ f389+ f390+ f391+ f392+ f393+ f394+ f395+ f396+ f397+ f398+ f399+ f400+ f401+ f402+ f403+ f404+ f405+ f406+ f407+ f408+ f409+ f410+ f411+ f412+ f413+ f414+ f415+ f416+ f417+ f418+ f419+ f420+ f421+ f422+ f423+ f424+ f425+ f426+ f427+ f428+ f429+ f430+ f431+ f432+ f433+ f434+ f435+ f436+ f437+ f438+ f439+ f440+ f441+ f442+ f443+ f444+ f445+ f446+ f447+ f448+ f449+ f450+ f451+ f452+ f453+ f454+ f455+ f456+ f457+ f458+ f459+ f460+ f461+ f462+ f463+ f464+ f465+ f466+ f467+ f468+ f469+ f470+ f471+ f472+ f473+ f474+ f475+ f476+ f477+ f478+ f479+ f480+ f481+ f482+ f483+ f484+ f485+ f486+ f487+ f488+ f489+ f490+ f491+ f492+ f493+ f494+ f495+ f496+ f497+ f498+ f499+ f500+ f501+ f502+ f503+ f504+ f505+ f506+ f507+ f508+ f509+ f510+ f511+ f512+ f513+ f514+ f515+ f516+ f517+ f518+ f519+ f520+ f521+ f522+ f523+ f524+ f525+ f526+ f527+ f528+ f529+ f530+ f531+ f532+ f534+ f535+ f536+ f537+ f538+ f539+ f540+ f541+ f542+ f543+ f544+ f545+ f546+ f547+ f548+ f549+ f550+ f551+ f552+ f553+ f554+ f555+ f556+ f557+ f558+ f559+ f560+ f561+ f562+ f563+ f564+ f565+ f566+ f567+ f568+ f569+ f570+ f571+ f572+ f573+ f574+ f575+ f576+ f577+ f578+ f579+ f580+ f581+ f582+ f583+ f584+ f585+ f586+ f587+ f588+ f589+ f590+ f591+ f592+ f593+ f594+ f595+ f596+ f597+ f598+ f599+ f600+ f601+ f602+ f603+ f604+ f605+ f606+ f607+ f608+ f609+ f610+ f611+ f612+ f613+ f614+ f615+ f616+ f617+ f618+ f619+ f620+ f621+ f622+ f623+ f624+ f625+ f626+ f627+ f628+ f629+ f630+ f631+ f632+ f633+ f634+ f635+ f636+ f637+ f638+ f639+ f640+ f641+ f642+ f643+ f644+ f645+ f646+ f647+ f648+ f649+ f650+ f651+ f652+ f653+ f654+ f655+ f656+ f657+ f658+ f659+ f660+ f661+ f662+ f663+ f664+ f665+ f666+ f667+ f668+ f669+ f670+ f671+ f672+ f673+ f674+ f675+ f676+ f677+ f679+ f680+ f681+ f682+ f683+ f684+ f685+ f686+ f687+ f688+ f689+ f690+ f691+ f692+ f693+ f694+ f695+ f696+ f697+ f698+ f699+ f700+ f701+ f702+ f703+ f704+ f705+ f706+ f707+ f708+ f709+ f710+ f711+ f712+ f713+ f714+ f715+ f716+ f717+ f718+ f719+ f720+ f721+ f722+ f723+ f724+ f725+ f726+ f727+ f728+ f729+ f730+ f731+ f732+ f733+ f734+ f735+ f736+ f737+ f738+ f739+ f740+ f741+ f742+ f743+ f744+ f745+ f746+ f747+ f748+ f749+ f750+ f751+ f752+ f753+ f754+ f755+ f756+ f757+ f758+ f759+ f760+ f761+ f762+ f763+ f764+ f765+ f766+ f767+ f768+ f769+ f770+ f771+ f772+ f773+ f774+ f775+ f776+ f777+ f778+ f779+ f780+ f781+ f782+ f783+ f784+ f785+ f786+ f787+ f788+ f789+ f790+ f791+ f792+ f793+ f794+ f795+ f796+ f797+ f798+ f799+ f800+ f801+ f802+ f803+ f804+ f805+ f806+ f807+ f808+ f809+ f810+ f811+ f812+ f813+ f814+ f815+ f816+ f817+ f818+ f819+ f820+ f821+ f822+ f824+ f825+ f826+ f827+ f828+ f829+ f830+ f831+ f832+ f833+ f834+ f835+ f836+ f837+ f838+ f839+ f840+ f841+ f842+ f843+ f844+ f845+ f846+ f847+ f848+ f849+ f850+ f851+ f852+ f853+ f854+ f855+ f856+ f857+ f858+ f859+ f860+ f861+ f862+ f863+ f864+ f865+ f866+ f867+ f868+ f869+ f870+ f871+ f872+ f873+ f874+ f875+ f876+ f877+ f878+ f879+ f880+ f881+ f882+ f883+ f884+ f885+ f886+ f887+ f888+ f889+ f890+ f891+ f892+ f893+ f894+ f895+ f896+ f897+ f898+ f899+ f900+ f901+ f902+ f903+ f904+ f905+ f906+ f907+ f908+ f909+ f910+ f911+ f912+ f913+ f914+ f915+ f916+ f917+ f918+ f919+ f920+ f921+ f922+ f923+ f924+ f925+ f926+ f927+ f928+ f929+ f930+ f931+ f932+ f933+ f934+ f935+ f936+ f937+ f938+ f939+ f940+ f941+ f942+ f943+ f944+ f945+ f946+ f947+ f948+ f949+ f950+ f951+ f952+ f953+ f954+ f955+ f956+ f957+ f958+ f959+ f960+ f961+ f962+ f963+ f964+ f965+ f966+ f967+ f969+ f970+ f971+ f972+ f973+ f974+ f975+ f976+ f977+ f978+ f979+ f980+ f981+ f982+ f983+ f984+ f985+ f986+ f987+ f988+ f989+ f990+ f991+ f992+ f993+ f994+ f995+ f996+ f997+ f998+ f999+ f1000+ f1001+ f1002+ f1003+ f1004+ f1005+ f1006+ f1007+ f1008+ f1009+ f1010+ f1011+ f1012+ f1013+ f1014+ f1015+ f1016+ f1017+ f1018+ f1019+ f1020+ f1021+ f1022+ f1023+ f1024+ f1025+ f1026+ f1027+ f1028+ f1029+ f1030+ f1031+ f1032+ f1033+ f1034+ f1035+ f1036+ f1037+ f1038+ f1039+ f1040+ f1041+ f1042+ f1043+ f1044+ f1045+ f1046+ f1047+ f1048+ f1049+ f1050+ f1051+ f1052+ f1053+ f1054+ f1055+ f1056+ f1057+ f1058+ f1059+ f1060+ f1061+ f1062+ f1063+ f1064+ f1065+ f1066+ f1067+ f1068+ f1069+ f1070+ f1071+ f1072+ f1073+ f1074+ f1075+ f1076+ f1077+ f1078+ f1079+ f1080+ f1081+ f1082+ f1083+ f1084+ f1085+ f1086+ f1087+ f1088+ f1089+ f1090+ f1091+ f1092+ f1093+ f1094+ f1095+ f1096+ f1097+ f1098+ f1099+ f1100+ f1101+ f1102+ f1103+ f1104+ f1105+ f1106+ f1107+ f1108+ f1109+ f1110+ f1111+ f1112+ f1113+ f1114+ f1115+ f1116+ f1117+ f1118+ f1119+ f1120+ f1121+ f1122+ f1123+ f1124+ f1125+ f1126+ f1127+ f1128+ f1129+ f1130+ f1131+ f1132+ f1134+ f1135+ f1136+ f1137+ f1138+ f1139+ f1140+ f1141+ f1142+ f1143+ f1144+ f1145+ f1146+ f1147+ f1148+ f1149+ f1150+ f1151+ f1152+ f1153+ f1154+ f1155+ f1156+ f1157+ f1158+ f1159+ f1160, data=data_train)

#1160b
#fit.all <- randomForest(as.factor(f0) ~ f1+ f2+ f3+ f4+ f5+ f6+ f7+ f8+ f9+ f10+ f11+ f12+ f13+ f14+ f15+ f16+ f17+ f18+ f19+ f20+ f21+ f22+ f23+ f24+ f25+ f26+ f27+ f28+ f29+ f30+ f31+ f32+ f33+ f34+ f35+ f36+ f37+ f38+ f39+ f40+ f41+ f42+ f43+ f44+ f45+ f46+ f47+ f48+ f49+ f50+ f51+ f52+ f53+ f54+ f55+ f56+ f57+ f58+ f59+ f60+ f61+ f62+ f63+ f64+ f65+ f66+ f67+ f68+ f69+ f70+ f71+ f72+ f73+ f74+ f75+ f76+ f77+ f78+ f79+ f80+ f81+ f82+ f83+ f84+ f85+ f86+ f87+ f88+ f89+ f90+ f97+ f99+ f100+ f101+ f102+ f103+ f104+ f105+ f106+ f107+ f108+ f109+ f110+ f111+ f112+ f113+ f114+ f115+ f116+ f117+ f118+ f119+ f120+ f121+ f122+ f123+ f124+ f125+ f126+ f127+ f128+ f129+ f130+ f131+ f132+ f133+ f134+ f135+ f136+ f137+ f138+ f139+ f140+ f141+ f142+ f143+ f144+ f145+ f146+ f147+ f148+ f149+ f150+ f151+ f152+ f153+ f154+ f155+ f156+ f157+ f158+ f159+ f160+ f161+ f162+ f163+ f164+ f165+ f166+ f167+ f168+ f169+ f170+ f171+ f172+ f173+ f174+ f175+ f176+ f177+ f178+ f179+ f180+ f181+ f182+ f183+ f184+ f185+ f186+ f187+ f188+ f189+ f190+ f191+ f192+ f193+ f194+ f195+ f196+ f197+ f198+ f199+ f200+ f201+ f202+ f203+ f204+ f205+ f206+ f207+ f208+ f209+ f210+ f211+ f212+ f213+ f214+ f215+ f216+ f217+ f218+ f219+ f220+ f221+ f222+ f223+ f224+ f225+ f226+ f227+ f228+ f229+ f230+ f231+ f232+ f233+ f234+ f235+ f242+ f244+ f245+ f246+ f247+ f248+ f249+ f250+ f251+ f252+ f253+ f254+ f255+ f256+ f257+ f258+ f259+ f260+ f261+ f262+ f263+ f264+ f265+ f266+ f267+ f268+ f269+ f270+ f271+ f272+ f273+ f274+ f275+ f276+ f277+ f278+ f279+ f280+ f281+ f282+ f283+ f284+ f285+ f286+ f287+ f288+ f289+ f290+ f291+ f292+ f293+ f294+ f295+ f296+ f297+ f298+ f299+ f300+ f301+ f302+ f303+ f304+ f305+ f306+ f307+ f308+ f309+ f310+ f311+ f312+ f313+ f314+ f315+ f316+ f317+ f318+ f319+ f320+ f321+ f322+ f323+ f324+ f325+ f326+ f327+ f328+ f329+ f330+ f331+ f332+ f333+ f334+ f335+ f336+ f337+ f338+ f339+ f340+ f341+ f342+ f343+ f344+ f345+ f346+ f347+ f348+ f349+ f350+ f351+ f352+ f353+ f354+ f355+ f356+ f357+ f358+ f359+ f360+ f361+ f362+ f363+ f364+ f365+ f366+ f367+ f368+ f369+ f370+ f371+ f372+ f373+ f374+ f375+ f376+ f377+ f378+ f379+ f380+ f387+ f389+ f390+ f391+ f392+ f393+ f394+ f395+ f396+ f397+ f398+ f399+ f400+ f401+ f402+ f403+ f404+ f405+ f406+ f407+ f408+ f409+ f410+ f411+ f412+ f413+ f414+ f415+ f416+ f417+ f418+ f419+ f420+ f421+ f422+ f423+ f424+ f425+ f426+ f427+ f428+ f429+ f430+ f431+ f432+ f433+ f434+ f435+ f436+ f437+ f438+ f439+ f440+ f441+ f442+ f443+ f444+ f445+ f446+ f447+ f448+ f449+ f450+ f451+ f452+ f453+ f454+ f455+ f456+ f457+ f458+ f459+ f460+ f461+ f462+ f463+ f464+ f465+ f466+ f467+ f468+ f469+ f470+ f471+ f472+ f473+ f474+ f475+ f476+ f477+ f478+ f479+ f480+ f481+ f482+ f483+ f484+ f485+ f486+ f487+ f488+ f489+ f490+ f491+ f492+ f493+ f494+ f495+ f496+ f497+ f498+ f499+ f500+ f501+ f502+ f503+ f504+ f505+ f506+ f507+ f508+ f509+ f510+ f511+ f512+ f513+ f514+ f515+ f516+ f517+ f518+ f519+ f520+ f521+ f522+ f523+ f524+ f525+ f532+ f534+ f535+ f536+ f537+ f538+ f539+ f540+ f541+ f542+ f543+ f544+ f545+ f546+ f547+ f548+ f549+ f550+ f551+ f552+ f553+ f554+ f555+ f556+ f557+ f558+ f559+ f560+ f561+ f562+ f563+ f564+ f565+ f566+ f567+ f568+ f569+ f570+ f571+ f572+ f573+ f574+ f575+ f576+ f577+ f578+ f579+ f580+ f581+ f582+ f583+ f584+ f585+ f586+ f587+ f588+ f589+ f590+ f591+ f592+ f593+ f594+ f595+ f596+ f597+ f598+ f599+ f600+ f601+ f602+ f603+ f604+ f605+ f606+ f607+ f608+ f609+ f610+ f611+ f612+ f613+ f614+ f615+ f616+ f617+ f618+ f619+ f620+ f621+ f622+ f623+ f624+ f625+ f626+ f627+ f628+ f629+ f630+ f631+ f632+ f633+ f634+ f635+ f636+ f637+ f638+ f639+ f640+ f641+ f642+ f643+ f644+ f645+ f646+ f647+ f648+ f649+ f650+ f651+ f652+ f653+ f654+ f655+ f656+ f657+ f658+ f659+ f660+ f661+ f662+ f663+ f664+ f665+ f666+ f667+ f668+ f669+ f670+ f677+ f679+ f680+ f681+ f682+ f683+ f684+ f685+ f686+ f687+ f688+ f689+ f690+ f691+ f692+ f693+ f694+ f695+ f696+ f697+ f698+ f699+ f700+ f701+ f702+ f703+ f704+ f705+ f706+ f707+ f708+ f709+ f710+ f711+ f712+ f713+ f714+ f715+ f716+ f717+ f718+ f719+ f720+ f721+ f722+ f723+ f724+ f725+ f726+ f727+ f728+ f729+ f730+ f731+ f732+ f733+ f734+ f735+ f736+ f737+ f738+ f739+ f740+ f741+ f742+ f743+ f744+ f745+ f746+ f747+ f748+ f749+ f750+ f751+ f752+ f753+ f754+ f755+ f756+ f757+ f758+ f759+ f760+ f761+ f762+ f763+ f764+ f765+ f766+ f767+ f768+ f769+ f770+ f771+ f772+ f773+ f774+ f775+ f776+ f777+ f778+ f779+ f780+ f781+ f782+ f783+ f784+ f785+ f786+ f787+ f788+ f789+ f790+ f791+ f792+ f793+ f794+ f795+ f796+ f797+ f798+ f799+ f800+ f801+ f802+ f803+ f804+ f805+ f806+ f807+ f808+ f809+ f810+ f811+ f812+ f813+ f814+ f815+ f822+ f824+ f825+ f826+ f827+ f828+ f829+ f830+ f831+ f832+ f833+ f834+ f835+ f836+ f837+ f838+ f839+ f840+ f841+ f842+ f843+ f844+ f845+ f846+ f847+ f848+ f849+ f850+ f851+ f852+ f853+ f854+ f855+ f856+ f857+ f858+ f859+ f860+ f861+ f862+ f863+ f864+ f865+ f866+ f867+ f868+ f869+ f870+ f871+ f872+ f873+ f874+ f875+ f876+ f877+ f878+ f879+ f880+ f881+ f882+ f883+ f884+ f885+ f886+ f887+ f888+ f889+ f890+ f891+ f892+ f893+ f894+ f895+ f896+ f897+ f898+ f899+ f900+ f901+ f902+ f903+ f904+ f905+ f906+ f907+ f908+ f909+ f910+ f911+ f912+ f913+ f914+ f915+ f916+ f917+ f918+ f919+ f920+ f921+ f922+ f923+ f924+ f925+ f926+ f927+ f928+ f929+ f930+ f931+ f932+ f933+ f934+ f935+ f936+ f937+ f938+ f939+ f940+ f941+ f942+ f943+ f944+ f945+ f946+ f947+ f948+ f949+ f950+ f951+ f952+ f953+ f954+ f955+ f956+ f957+ f958+ f959+ f960+ f967+ f969+ f970+ f971+ f972+ f973+ f974+ f975+ f976+ f977+ f978+ f979+ f980+ f981+ f982+ f983+ f984+ f985+ f986+ f987+ f988+ f989+ f990+ f991+ f992+ f993+ f994+ f995+ f996+ f997+ f998+ f999+ f1000+ f1001+ f1002+ f1003+ f1004+ f1005+ f1006+ f1007+ f1008+ f1009+ f1010+ f1011+ f1012+ f1013+ f1014+ f1015+ f1016+ f1017+ f1018+ f1019+ f1020+ f1021+ f1022+ f1023+ f1024+ f1025+ f1026+ f1027+ f1028+ f1029+ f1030+ f1031+ f1032+ f1033+ f1034+ f1035+ f1036+ f1037+ f1038+ f1039+ f1040+ f1041+ f1042+ f1043+ f1044+ f1045+ f1046+ f1047+ f1048+ f1049+ f1050+ f1051+ f1052+ f1053+ f1054+ f1055+ f1056+ f1057+ f1058+ f1059+ f1060+ f1061+ f1062+ f1063+ f1064+ f1065+ f1066+ f1067+ f1068+ f1069+ f1070+ f1071+ f1072+ f1073+ f1074+ f1075+ f1076+ f1077+ f1078+ f1079+ f1080+ f1081+ f1082+ f1083+ f1084+ f1085+ f1086+ f1087+ f1088+ f1089+ f1090+ f1091+ f1092+ f1093+ f1094+ f1095+ f1096+ f1097+ f1098+ f1099+ f1100+ f1101+ f1102+ f1103+ f1104+ f1105+ f1112+ f1114+ f1115+ f1116+ f1117+ f1118+ f1119+ f1120+ f1121+ f1122+ f1123+ f1124+ f1125+ f1126+ f1127+ f1128+ f1129+ f1130+ f1131+ f1132+ f1133+ f1134+ f1135+ f1136+ f1137+ f1138+ f1139+ f1140+ f1141+ f1142+ f1143+ f1144+ f1145+ f1146+ f1147+ f1148+ f1149+ f1150+ f1151+ f1152+ f1153+ f1154+ f1155+ f1156+ f1157+ f1158+ f1159+ f1160, data=data_train)

# importance value
import <- importance(fit.all, sort = TRUE)
import <- import[order(import, decreasing=TRUE),,drop = FALSE]

#list of top30
import[1:30,,drop = FALSE]

#make top30 train set
data_train.30 <- data_train[,rownames(import)[1:30]]
fit.30 <- randomForest(as.factor(data_train$f0) ~.,
                                data=data_train.30, importance=TRUE, proximity=TRUE)

# Err rate plot
qplot(y=fit.30$err.rate[,1])

# importance plot
varImpPlot(fit.30)
importance(fit.30)
fit.30$confusion

# 5 fold cross validation / trainset
data_train.30$f0 = data_train$f0
sub_train <- data_train.30[sample(nrow(data_train.30)), ]

k=5
n=floor(nrow(data_train.30)/k)
val_err=0
i=1
sub1 = ((i-1)* n+1)
sub2 = (i*n)
subset = sub1:sub2
cross_val.trn = sub_train[-subset,]
cross_val.test = sub_train[subset,]
fit.sub <- randomForest(as.factor(f0) ~., data=cross_val.trn)
Prediction_crossval = predict(fit.sub, cross_val.test, type="prob")
cross_val.test$response <- ifelse(cross_val.test$f0=="1", 1, 0)
list_roc = roc(cross_val.test$response, Prediction_crossval[,2])
val_err[i] = list_roc$auc
plot.roc(list_roc, legacy.axes=TRUE, print.auc = TRUE, print.auc.x=0.25)

for(i  in 2:k)
{
  sub1 = ((i-1)* n+1)
  sub2 = (i*n)
  subset = sub1:sub2
  cross_val.trn = sub_train[-subset,]
  cross_val.test = sub_train[subset,]
  fit.sub <- randomForest(as.factor(f0) ~., data=cross_val.trn)
  Prediction_crossval = predict(fit.sub, cross_val.test, type="prob")
  cross_val.test$response <- ifelse(cross_val.test$f0=="1", 1, 0)
  list_roc = roc(cross_val.test$response, Prediction_crossval[,2])
  val_err[i] = list_roc$auc
  plot.roc(list_roc, legacy.axes=TRUE, print.auc = TRUE, add = TRUE, col = i, print.auc.y=0.5-(i-1)*0.05, print.auc.x=0.25)
}
print(paste("Average AUC:", mean(val_err)))
print(paste("STD", sd(val_err)))

#partial AUC (pAUC)
plot.roc(cross_val.test$response, Prediction_crossval[,2], percent=TRUE, partial.auc=c(100, 90), partial.auc.correct=TRUE, 
         print.auc=TRUE,print.auc.pattern="Corrected pAUC (100-90%% SP):\n%.1f%%", print.auc.col="#1c61b6",
         auc.polygon=TRUE, auc.polygon.col="#1c61b6", max.auc.polygon=TRUE, max.auc.polygon.col="#1c61b622", main="Partial AUC (pAUC)")

plot.roc(cross_val.test$response, Prediction_crossval[,2], percent=TRUE, add=TRUE, type="n", 
         partial.auc=c(100, 90), partial.auc.correct=TRUE, partial.auc.focus="se", 
         print.auc=TRUE, print.auc.pattern="Corrected pAUC (100-90%% SE):\n%.1f%%", print.auc.col="#008600",
         print.auc.y=40, auc.polygon=TRUE, auc.polygon.col="#008600",
         max.auc.polygon=TRUE, max.auc.polygon.col="#00860022")

#smoothing
rocobj <- plot.roc(cross_val.test$response, Prediction_crossval[,2],  percent = TRUE, main="Smoothing")
                  lines(smooth(rocobj), col = "#1c61b6")
                  lines(smooth(rocobj, method = "density"), col = "#008600")
                  lines(smooth(rocobj, method = "fitdistr", density = "lognormal"),col = "#840000")
                  legend("bottomright", legend = c("Empirical", "Binormal", "Density", "Fitdistr\n(Log-normal)"), col = c("black", "#1c61b6", "#008600", "#840000"),lwd = 2)

#Confidence intervals of specificity/sensitivity                  
rocobj <- plot.roc(cross_val.test$response, Prediction_crossval[,2], 
                   main="Confidence intervals of specificity/sensitivity", percent=TRUE,
                   ci=TRUE, of="se",specificities=seq(0, 100, 5), ci.type="shape", ci.col="#1c61b6AA") 

plot(ci.sp(rocobj, sensitivities=seq(0, 100, 5)), type="bars") 

#predict test data
data_test <- data_test[sample(nrow(data_test)), ]  
Prediction.test <- predict(fit.30, data_test, type="prob")
Prediction.test.res = as.factor(ifelse(Prediction.test[,2] >= 0.5, "1", "0"))
tab = table(Prediction.test.res, data_test$f0)
print(tab)
cat(paste(paste("sensitivity (TPR)", tab[2,2]/(tab[2,2]+tab[1,2])*100), 
          paste("specificity (TNR)", tab[1,1]/(tab[1,1]+tab[2,1])*100), 
          sep="\n"))

# ROC test data
data_test$response <- ifelse(data_test$f0=="1", 1, 0)
roc.plot(data_test$response, Prediction.test[,2])
paste("AUC (test data)", roc.area(data_test$response, Prediction.test[,2])$A)

# box plot
data_test$label <- ifelse(data_test$f0=="1", "positive", "negative")
boxdata <- data.frame(Type = data_test$label, Prediction = Prediction.test[,2])
ggplot(data = boxdata, aes(Type, Prediction, color=Type)) + geom_boxplot(lwd=0.8, notch = TRUE)
