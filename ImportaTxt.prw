#include "totvs.ch"
#include "protheus.ch"

User Function ImportaTxt()

Local cTitulo := "Escolha o Arquivo "
Local cMascara := "Todos os Arquivos"
Local cDirinicial := "C:\"  
Local cArq    := cGetFile(cMascara,cTitulo,/*nMascpadrao*/,cDirinicial,.T.,/*nOpcoes*/,.T.,.T.) 
Local cLinha  := ""
Local lPrim   := .T.
Local aCampos := {}
Local aDados  := {}
 
Private aErro := {}
 

If !File(cArq)
	MsgStop("O arquivo " + cArq + " não foi encontrado. A importação será abortada!","[ImportaTxt] - ATENCAO")
	Return
EndIf
 
FT_FUSE(cArq) // esta usando o arquivo selecionado via cGetFile
ProcRegua(FT_FLASTREC()) // lendo a quantidade de linhas no arquivo 
FT_FGOTOP()//posiciona no inicio do arquivo
While !FT_FEOF() // enquanto o ponteiro não estiver no final do aqruivo 
 
	IncProc("Lendo arquivo texto...") // ler o arquivo 
 
	cLinha := FT_FREADLN()
 
	If lPrim // se for a primeira linha, sera considerada como nome do campo
		aCampos := Separa(cLinha,";",.T.)
		lPrim := .F.
	Else // senão serão dados  
		AADD(aDados,Separa(cLinha,";",.T.))
		MsgAlert( "Linha: " + cLinha ) // Utilizado somente para verificar se o array estava sendo alimentado 

	EndIf
 
	FT_FSKIP() // move o ponteiro para o Proximo 
EndDo

ApMsgInfo("Importação dos Clientes concluída com sucesso!","[ImportaTxt] - SUCESSO")

Return



