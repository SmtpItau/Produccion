USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSACTUAL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_POSACTUAL]
            ( @Moneda    CHAR(3) ,
              @Negocio   NUMERIC(3) = 0) -- Consolidado segun MENEG
AS
BEGIN
SET NOCOUNT ON
 IF @Moneda = 'USD'    
    BEGIN
       SELECT acposini ,
              acposic ,
              acpmeco  ,
              acpmeve ,
              actotco  ,
              actotve ,
              acutili  ,
              acpreini  ,
              acprecie , -- Trading
              0         ,       -- vmposition  ,       -- Position
              achedgeinicialfuturo,
              achedgeinicialspot,
              achedgeactualfuturo,
              achedgeactualspot,
              achedgeprecioinicial,
              achedgeutilidad,
              acultpta,
              acultmon,
              acultpre,
              accosvent,
              accoscomp,
   	      achedgevctofuturo	,	
	      acacumdia		,
              acacummes		,
              AcTradingFicticio	,
              actotcopo         ,
              actotvepo

         FROM MEAC
    END
 ELSE
    BEGIN
       SELECT vmposini ,
              vmposic ,
              vmpmeco  ,
              vmpmeve ,
              vmtotco  ,
              vmtotve ,
              vmutili  ,
              vmpreini1 = ( CASE @Moneda 
                          WHEN 'USD'  THEN vmpreini 
                                      ELSE vmparidad             
                          END ),     
              vmprecierre , -- Trading
              vmposition  ,       -- Position
              achedgeinicialfuturo,
              achedgeinicialspot,
              achedgeactualfuturo,
              achedgeactualspot,
              achedgeprecioinicial,
              achedgeutilidad,
              acultpta,
              acultmon,
              acultpre,
              accosvent,
              accoscomp,
              achedgevctofuturo   ,
              acacumdia		  ,
              acacummes           ,
              AcTradingFicticio	
         FROM VIEW_POSICION_SPT ,
       MEAC
        WHERE CONVERT(CHAR(8),acfecpro,112) = CONVERT(CHAR(8),vmfecha,112) AND
              vmcodigo  = @Moneda AND 
              vmnegocio = @Negocio
    END
SET NOCOUNT OFF
END



GO
