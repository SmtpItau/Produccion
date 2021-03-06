USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMONEDAS_POS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE  PROCEDURE [dbo].[SP_LEEMONEDAS_POS]
AS
BEGIN   
     SET NOCOUNT ON
          
     SELECT  mnrrda
           , mnglosa
           , mnnemo
           , CONVERT(FLOAT,0) as posini
           , CONVERT(FLOAT,0) as posic
           , CONVERT(FLOAT,0) as totco
           , CONVERT(FLOAT,0) as totve
           , CONVERT(FLOAT,0) as parmes
           , CONVERT(FLOAT,0) as paridad
           , CONVERT(FLOAT,0) as preini
           , mncodmon
           , mncodpais            -- pais para buscar feriados
           , LEFT(mnsimbol,3) as mnsimbol
      INTO  #moneda
      FROM   VIEW_MONEDA
     WHERE   mnmx = 'C' --OR mncodmon in (998,999)
     ORDER BY mnglosa
     UPDATE #moneda SET posini  = vmposini
                      , posic   = vmposic
                      , totco   = vmtotco
                      , totve   = vmtotve
                      , parmes  = vmparmes
                      , paridad = vmparidad
                      , preini  = vmpreini
                  FROM  view_posicion_spt,
                        meac
                 WHERE  CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),acfecpro,112)
                   AND  mnsimbol = vmcodigo
     SELECT * FROM #moneda
END
 
 
GO
