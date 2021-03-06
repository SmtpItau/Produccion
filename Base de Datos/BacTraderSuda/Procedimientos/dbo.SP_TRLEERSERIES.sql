USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRLEERSERIES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRLEERSERIES]
            ( @Rut_Emisor  NUMERIC(10) )
AS
BEGIN  
SET NOCOUNT ON
DECLARE @Rut_Central NUMERIC(10)
SELECT @Rut_Central = 97029000
    SELECT 'trcount'  = (SELECT COUNT(*) FROM VIEW_INSTRUMENTO 
                         WHERE  view_instrumento.inserie NOT IN ('ICAP','ICOL','CPACTO',
           'PRT-DH','CE1649',
           'CE1691','PRTUS$',
           'DPR-TC','DPRT',
           'FMUTUO','COR','1836',
           'ICOLUS')  
        AND ((@Rut_Emisor =  @Rut_Central AND inrutemi  = @Rut_Emisor  ) OR
   
          (@Rut_Emisor <> @Rut_Central AND inrutemi <> @Rut_Central ) ) ) ,
           'trserie'  = view_instrumento.inserie
    FROM   VIEW_INSTRUMENTO 
   WHERE  view_instrumento.inserie NOT IN( 'ICAP','ICOL','CPACTO',
         'PRT-DH','CE1649',
    'CE1691','PRTUS$',
    'DPR-TC','DPRT',
    'FMUTUO','COR','1836',
    'ICOLUS')
     AND ((@Rut_Emisor =  @Rut_Central AND inrutemi  = @Rut_Emisor  ) OR
          (@Rut_Emisor <> @Rut_Central AND inrutemi <> @Rut_Central ) )
SET NOCOUNT OFF
    RETURN
END

GO
