#include 'protheus.ch'
#include 'parmtype.ch'
#Include "topconn.Ch"
#Include "FWMVCDef.Ch"

   
#Define TITULO "Doc. Entradas Nfs"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AFIS011   �Autor  � Victor Araujo      � Data � 22/06/2016  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina para consulta e manutencao dos lancamentos          ���
���          � (notas fiscais de entrada) para o EFD Contribuicoes.       ���
�������������������������������������������������������������������������͹��
���Uso       � SCASE TECNOLOGIA		                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function AFIS011()

Local oBrowse	:= Nil
Local aColunas 	:= {}
Local cAliasTrb	:= GetNextAlias()

//��������������������������������������������������������������������������Ŀ
//� Monta os dados da TRB.													 �
//����������������������������������������������������������������������������	
MsgRun( "Montando a tela com os dados..." , "Aguarde" , {||fMtQuery(cAliasTrb,@aColunas) } )

//��������������������������������������������������������������������������Ŀ
//� Instancia a Classe de Browse.											 �
//����������������������������������������������������������������������������	
oBrowse := FWMBrowse():New()
	
//��������������������������������������������������������������������������Ŀ
//� Definicao da tabela do Browse.											 �
//����������������������������������������������������������������������������
oBrowse:SetAlias(cAliasTrb)
	
//��������������������������������������������������������������������������Ŀ
//� //seta as colunas para o browse.							  			 �
//����������������������������������������������������������������������������
oBrowse:Setfields(aColunas)   

//��������������������������������������������������������������������������Ŀ
//� //seta o menu para o browse.		     					  			 �
//����������������������������������������������������������������������������	
//oBrowse:SetMenuDef("AFIS011")	
	
//��������������������������������������������������������������������������Ŀ
//� Definicao do titulo do Browse.											 �
//����������������������������������������������������������������������������
oBrowse:SetDescription(TITULO)
	
//��������������������������������������������������������������������������Ŀ
//� Desabilita a exibicao dos Detalhes.										 �
//����������������������������������������������������������������������������
oBrowse:DisableDetails()
	
//��������������������������������������������������������������������������Ŀ
//� Ativacao da Classe de Browse.											 �
//����������������������������������������������������������������������������
oBrowse:Activate()
	
return()

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �MenuDef   �Autor  �Victor Araujo       � Data � 22/06/2016  ���
�������������������������������������������������������������������������͹��
���Desc.     �Define as opcoes do aRotina.				                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SCASE TECNOLOGIA                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


Static function MenuDef()

Local aRotina	:= {}

ADD OPTION aRotina TITLE 'Visualizar' 		ACTION 'VIEWDEF.AFIS011'	OPERATION 1 ACCESS 0
ADD OPTION aRotina TITLE 'Imprimir'			ACTION 'VIEWDEF.AFIS011' 	OPERATION 8 ACCESS 0


return(aRotina)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ModelDef  �Autor  � Victor Araujo      � Data � 22/06/2016  ���
�������������������������������������������������������������������������͹��
���Desc.     �Define o Modelo de Interface.				                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SCASE TECNOLOGIA		                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


Static Function ModelDef()

//��������������������������������������������������������������������������Ŀ
//� Cria a estrutura a ser usada no Modelo de Dados.						 �
//����������������������������������������������������������������������������

	Local oStrucTRB := FWFormStruct( 1, "TRB" )
    Local oModel := nil
    
    
//��������������������������������������������������������������������������Ŀ
//� Cria o objeto do Modelo de Dados.										 �
//����������������������������������������������������������������������������
	oModel := MPFormModel():New("AFIS011M",/*bPreValidacao*/,/*bPosValidacao*/,/*bCommit*/,/*bCancel*/)
		
//��������������������������������������������������������������������������Ŀ
//� Adiciona a descricao do Modelo de Dados.								 �
//����������������������������������������������������������������������������

	oModel:SetDescription(TITULO)
	
	oModel:AddFields("TRBMASTER",/*cOwner*/,oStrucTRB,/*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )
	
	oModel:GetModel('TRBMASTER'):SetDiscription	('Doc. Entradas Nfs')
	
	oModel:SetVldActivate( { |oModel| fValidaMod( oModel ) } )
			
Return(oModel)                                  

Static Function fValidaMod( oModel )

Local lRet       := .T.

Return(lRet)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ViewDef   �Autor  � Victor Araujo      � Data � 22/06/2016  ���
�������������������������������������������������������������������������͹��
���Desc.     �Define o Modelo de Interface.				                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SCASE TECNOLOGIA		                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ViewDef()

//��������������������������������������������������������������������������Ŀ
//�Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado. �
//����������������������������������������������������������������������������

	Local oModel := FWLoadModel("AFIS011")
	
//��������������������������������������������������������������������������Ŀ
//�Cria a estrutura a ser usada na View. 									 �
//����������������������������������������������������������������������������

	Local oStrucTRB  := FWFormStruct(2,"TRB")
	Local oView 	 := Nil
	
//��������������������������������������������������������������������������Ŀ
//�Cria o objeto de View.				 									 �
//����������������������������������������������������������������������������
	
	oView := FWformView():New()
		
//��������������������������������������������������������������������������Ŀ
//�Define qual o Modelo de dados ser� utilizado.							 �
//����������������������������������������������������������������������������

	oView:SetModel(oModel)

//��������������������������������������������������������������������������Ŀ
//�Adiciona no nosso View um controle do tipo FormFields(antiga enchoice).	 �
//����������������������������������������������������������������������������

	oView:AddField("VIEW_TRB", oStrucTRB , "TRBMASTER")
	
//��������������������������������������������������������������������������Ŀ
//�Criar um "box" horizontal para receber algum elemento da view.			 �
//����������������������������������������������������������������������������
	
	oViewCreatHorizontalBox("TELA",100)

//��������������������������������������������������������������������������Ŀ
//�Relaciona o ID da View com o "box" para exibicao.						 �
//����������������������������������������������������������������������������


	oView:SetOwnerView("VIEW_TRB", "TELA")

Return(oView)

/* 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��                                                	
���Funcao    �fMntQuery �Autor  �Victor Araujo   � Data � 17/06/2016  ���
�������������������������������������������������������������������������͹��
���Desc.     �Monta Query.			                                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SCASE TECNOLOGIA                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


Static function fMtQuery(cAliasTrb,aColunas)

  
Local cQuery	:= "" 

//��������������������������������������������������������������������������Ŀ
//� Seleciona os registros.													 �
//����������������������������������������������������������������������������	
cQuery	+=	" SELECT	F1_DOC		,	F1_SERIE	,	
cQuery	+=	" 			F1_TIPO		, 	F1_EMISSAO	,	
cQuery	+=	" 			F1_DTDIGIT	,	F1_DTLANC	,
cQuery	+=	" 			F1_FORNECE 	,	F1_LOJA 	,
cQuery	+=	" 			A2_NOME 	,	A2_CGC 		,
cQuery	+=	" 			A2_END		,	A2_BAIRRO	,
cQuery	+=	" 			A2_EST		,	A2_CEP		,
cQuery	+=	" 			A2_MUN		,	D1_ITEM		,
cQuery	+=	" 			D1_COD 		,	B1_DESC		,
cQuery	+=	" 			D1_UM		,	D1_TES		,
cQuery	+=	" 			F4_TEXTO	,	D1_CONTA	,
cQuery	+=	" 			D1_CC 		,	D1_TOTAL	,
cQuery	+=	" 			D1_RATEIO 	,	FT_CFOP		,
cQuery	+=	" 			FT_CODISS	,	FT_VALCONT 	,	
cQuery	+=	" 			FT_TOTAL 	,	FT_OBSERV 	,
cQuery	+=	" 			FT_DTCANC 	,	FT_ESPECIE	,	
cQuery	+=	" 			FT_CLASFIS	,	FT_BASEPIS 	,	
cQuery	+=	" 			FT_ALIQPIS	,	FT_VALPIS	,	
cQuery	+=	" 			FT_CSTPIS	,	FT_BASECOF	,	
cQuery	+=	" 			FT_ALIQCOF	,	FT_VALCOF	,	
cQuery	+=	" 			FT_CSTCOF 	,	A2_ESTADO

cQuery	+=	" FROM		"+RetSqlName("SF1")+"	SF1

cQuery	+=	" JOIN		"+RetSqlName("SA2")+"	SA2
cQuery	+=	" ON	 	SA2.D_E_L_E_T_	<> '*'
cQuery	+=	" AND 		SA2.A2_COD 		= 	SF1.F1_FORNECE 	
cQuery	+=	" AND 		SA2.A2_LOJA 	= 	SF1.F1_LOJA  	

cQuery	+=	" JOIN		"+RetSqlName("SD1")+" SD1
cQuery	+=	" ON 		SD1.D_E_L_E_T_	<> '*'
cQuery	+=	" AND 		SD1.D1_FILIAL 	= SF1.F1_FILIAL
cQuery	+=	" AND 		SD1.D1_FORNECE	= SF1.F1_FORNECE
cQuery	+=	" AND 		SD1.D1_LOJA 	= SF1.F1_LOJA	
cQuery	+=	" AND 		SD1.D1_DOC 		= SF1.F1_DOC	
cQuery	+=	" AND 		SD1.D1_SERIE 	= SF1.F1_SERIE	

cQuery	+=	" JOIN		"+RetSqlName("SB1")+" SB1
cQuery	+=	" ON  		SB1.D_E_L_E_T_	<> '*'
cQuery	+=	" AND 		SB1.B1_COD 		= SD1.D1_COD

cQuery	+=	" JOIN		"+RetSqlName("SF4")+" SF4
cQuery	+=	" ON  		SF4.D_E_L_E_T_	<>'*'			 
cQuery	+=	" AND 		SF4.F4_CODIGO 	= SD1.D1_TES		  

cQuery	+=	" JOIN		"+RetSqlName("SFT")+" SFT 
cQuery	+=	" ON  		SFT.D_E_L_E_T_<>'*'			
cQuery	+=	" AND 		SFT.FT_FILIAL 	= SD1.D1_FILIAL	
cQuery	+=	" AND 		SFT.FT_CLIEFOR 	= SD1.D1_FORNECE
cQuery	+=	" AND 		SFT.FT_LOJA 	= SD1.D1_LOJA	
cQuery	+=	" AND		SFT.FT_NFISCAL 	= SD1.D1_DOC	
cQuery	+=	" AND 		SFT.FT_SERIE 	= SD1.D1_SERIE	
cQuery	+=	" AND  		SFT.FT_TIPOMOV 	= 'E'		

cQuery	+=	" JOIN		"+RetSqlName("ZE0")+" ZE0
cQuery	+=	" ON	 	ZE0.D_E_L_E_T_	<> '*' 

cQuery	+=	" WHERE 	SF1.D_E_L_E_T_	<>'*'	
cQuery	+=	" AND 		SF1.F1_EMISSAO	BETWEEN	'20160501'	AND '20160531'

cQuery	+=	" ORDER		BY SF1.F1_FILIAL, SF1.F1_FORNECE, SF1.F1_LOJA, SF1.F1_EMISSAO, SF1.F1_DOC, SF1.F1_SERIE
	
cQuery := ChangeQuery(cQuery)
DBUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTrb,.T.,.T.)

//��������������������������������������������������������������������������Ŀ
//� Configura colunas para uso na Browse.									 �
//����������������������������������������������������������������������������	
//Colunas que serao apresentados na tabela temporaria
aColunas :=	{	{"Documento"			, 	"F1_DOC" 		, "C",9,0,"@!"}	,; 
				{"Serie"				,	"F1_SERIE"		, "C",3,0,"@!"}	,;
				{"Tipo"					,	"F1_TIPO"		, "C",0,0,"@!"} ,; 
				{"Dt. Emissao"			,	"F1_EMISSAO"	, "D",8,0,"@!"} ,;
				{"Dt. Digita"			,	"F1_DTDIGIT"	, "D",8,0,"@!"} ,;
				{"Dt. Contabil"			,	"F1_DTLANC"		, "D",8,0,"@!"} ,;
				{"Cod. Fornecedor"		,  	"F1_FORNECE"	, "C",6,0,"@!"} ,;
				{"Loja"					,	"F1_LOJA"		, "C",1,0,"@!"} ,;
				{"Raz�o Social"			,	"A2_NOME"		, "C",40,0,"@!"},;
				{"CNPJ"					,	"A2_CGC"		, "C",14,0,"@!"},;
				{"Endere�o"				, 	"A2_END"		, "C",40,0,"@!"},;
				{"Bairro"				, 	"A2_BAIRRO"		, "C",20,0,"@!"},;
				{"Estado"				, 	"A2_ESTADO"		, "C",20,0,"@!"},;
				{"CEP"					, 	"A2_CEP"		, "C",8,0,"@!"} ,;
				{"Cidade"				, 	"A2_MUN"		, "C",15,0,"@!"},;
				{"Item NF"				, 	"D1_ITEM"		, "C",4,0,"@!"}	,;
				{"Cod. Pruduto"			, 	"D1_COD"		, "C",15,0,"@!"},;
				{"Descri��o Produto"	,	"B1_DESC"		, "C",30,0,"@!"},;
				{"Unidade de Medida"	,	"D1_UM"			, "C",2,0,"@!"}	,;
				{"Cod. TES"				, 	"D1_TES"		, "C",3,0,"@!"}	,;
				{"Opera��o" 			, 	"F4_TEXTO"		, "C",0,0,"@!"}	,;
				{"Conta Contabil"		, 	"D1_CONTA"		, "C",20,0,"@!"},;
				{"Centro de Custo"		, 	"D1_CC"			, "C",15,0,"@!"},;
				{"Valor Total"			, 	"D1_TOTAL"		, "N",8,2,"@E 9,999,999,999.99"},;
				{"Rareio(1=Sim/2=N�o)"	,	"D1_RATEIO"		, "C",1,0,"@!"},;
				{"CFOP"					, 	"FT_CFOP"		, "C",5,0,"@!"},;
				{"Cod. ISS"				, 	"FT_CODISS"		, "C",9,0,"@!"},;
				{"Valor Contabil"		, 	"FT_VALCONT"	, "N",14,2,"@E 99,999,999,999.99"},;
				{"Valor Fiscal"			, 	"FT_TOTAL"		, "N",16,2,"@E 9,999,999,999.99"},;
				{"Observa��o"			, 	"FT_OBSERV"		, "C",31,0,"@!"},;
				{"Dt. Cancelado"		, 	"FT_DTCANC"		, "D",8,0,"@!"},;
				{"Especie"				, 	"FT_ESPECIE"	, "C",5,0,"@!"},;
				{"Clas. Fiscal"			,	"FT_CLASFIS"	, "C",3,0,"@!"},; 
				{"Base PIS"				,	"FT_BASEPIS"	, "N",16,2,"@E 9,999,999,999.99"},;
				{"Aliq. PIS"			,	"FT_ALIQPIS"	, "N",16,2,"@E 9,999,999,999.99"},;
				{"Valor PIS"			,	"FT_VALPIS"		, "N",16,2,"@E 9,999,999,999.99"},;
				{"CST PIS"				,	"FT_CSTPIS"		, "C",2,0,"@!"},;
				{"Base COFINS"			,	"FT_BASECOF"	, "N",16,2,"@E 9,999,999,999.99"},;
				{"Aliq. COFINS"			,	"FT_ALIQCOF"	, "N",16,2,"@E 9,999,999,999.99"},;
				{"Valor COFINS"			,	"FT_VALCOF"		, "N",16,2,"@E 9,999,999,999.99"},;
				{"CST COFINS"			,	"FT_CSTCOF"		, "C",2,0,"@!"}}
				
				
Return()