USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_Clausulas_contrato_impreso]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CONTRATO_Clausulas_contrato_impreso]
(
		@NumOper	as	int
	,	@RutCli		as	int
)

AS 
BEGIN
SET NOCOUNT ON

DELETE FROM CONTRATO_ContratosClausulasSeleccionadas 

INSERT INTO CONTRATO_ContratosClausulasSeleccionadas ( Rut_Cliente, Cod_Cliente, Numero_Operacion, sistema, Contrato, Categoria, Clausula)
	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'CCG'
	AND Cod_Dcto = 'CCG'
 
	UNION

	
	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CLAUSULA'
		,	'Clausula'	= Cod_Dcto
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'CCG'
	AND Cod_Dcto <> Cod_Dcto_Fisico
 
	UNION
 
	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'ASCG'
	AND Cod_Dcto = 'ASCG'
  
	UNION
 
	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CLAUSULA'
		,	'Clausula'	= Cod_Dcto
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'ASCG'
	AND Cod_Dcto <> Cod_Dcto_Fisico
 
	UNION
	
	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'CE'
	AND Cod_Dcto = 'CE'
  
	UNION

	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= Cod_Dcto
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'ACCE'
	AND Cod_Dcto = 'ACCE'
   
	UNION
	
	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CLAUSULA'
		,	'Clausula'	= Cod_Dcto
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'ACCE'
	AND Cod_Dcto <> Cod_Dcto_Fisico

	UNION

	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'AEFE'
	AND Cod_Dcto = 'AEFE'

	UNION

		select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'AESM'
	AND Cod_Dcto = 'AESM'

	UNION


		select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'AEST'
	AND Cod_Dcto = 'AEST'

	UNION

	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'ACOP'
	AND Cod_Dcto = 'ACOP'

		UNION

	select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CONTRATO'
		,	'Clausula'	= ''
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'ASOP'
	AND Cod_Dcto = 'ASOP'

	UNION

		select	Rut_Cliente
		,	Cod_Cliente
		,	Num_Oper
		,	Sistema
		,	'Contrato'	= Cod_Dcto_Fisico 			
		,	'Categoria'	= 'CLAUSULA'
		,	'Clausula'	= Cod_Dcto
	from
	CONTRATO_Contratos_Impresos where num_oper = @NumOper and Rut_Cliente = @RutCli
	AND Cod_Dcto_Fisico  = 'ASOP'
	AND Cod_Dcto <> Cod_Dcto_Fisico


 END 
GO
