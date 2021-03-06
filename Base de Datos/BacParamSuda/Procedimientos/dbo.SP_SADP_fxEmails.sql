USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_fxEmails]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_fxEmails]
AS 
BEGIN
	
		DECLARE @sRespuesta VARCHAR(255)		;	
			SET @sRespuesta ='' ;
	
	SET NOCOUNT ON ;
		
	DECLARE @iX			INT
	,		@nContador  INT
	,		@iCpd		SMALLINT
	,		@sDato		VARCHAR(100)
			
	DECLARE @Revi	TABLE( Reg	VARCHAR(50), nRegi NUMERIC(10) IDENTITY(1,1) )						
		SET @iX        = 1					

		SET @iCpd	 =(SELECT cod_rolemail FROM sadp_control) ;
 
	INSERT INTO @revi(reg)  
	SELECT eMail 
	  FROM bacparamsuda.dbo.sadp_rolusuario sr 
	 WHERE sr.RolInterno = @iCpd	  

	   SET @nContador = (SELECT MAX(Nregi) FROM @revi);
 		
	SET @sRespuesta = ''
	 
	WHILE @iX<=@nContador
	BEGIN
		
		SELECT @sDato = LTRIM(Rtrim(reg))	
		 FROM @revi
		WHERE Nregi        = @iX   	;
		
				
		SELECT @sRespuesta =  ltrim(rtrim(@sRespuesta)) +  rtrim(@sDato) +  CASE WHEN @iX=@nContador THEN '' ELSE ';' END ; 
		SET @iX                = @iX + 1		;
		
		
	END
	SELECT @sRespuesta AS Emails , 'Aprobacion Requerida en SADP' AS Subject,'Las siguientes operaciones necesitan su visado ' AS Body		
END
GO
