USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MONEDA_POS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEE_MONEDA_POS]
       (
        @cMoneda   CHAR(03)='  '
       )
AS
BEGIN   
    SET NOCOUNT OFF
   IF EXISTS( SELECT       *
                     FROM  VIEW_MONEDA A, VIEW_POSICION_SPT B, MEAC
                     WHERE CONVERT(CHAR(8),b.vmfecha,112) = CONVERT(CHAR(8),acfecpro,112) AND 
                           a.mnmx                         = 'C'                           AND 
                           SUBSTRING( a.mnsimbol, 1, 3 )  = b.vmcodigo                    AND
                           vmcodigo                       = @cMoneda ) BEGIN
          
      SELECT          mnrrda        , --modoficado mncodmon
                      mnglosa,
                      mnnemo ,--modoficado mnsimbol
                      b.vmposini    ,
                      b.vmposic     ,
                      b.vmtotco     ,
                      b.vmtotve     ,
                      b.vmparmes    ,
                      b.vmparidad   ,
                      b.vmpreini    ,
                      mncodmon      
             FROM     VIEW_MONEDA  A, VIEW_POSICION_SPT  B, MEAC    --MEAC
             WHERE    CONVERT(CHAR(8),b.vmfecha,112) = CONVERT(CHAR(8),acfecpro,112) AND 
                      a.mnmx                         = 'C'                           AND 
                      SUBSTRING( a.mnsimbol, 1, 3 )  = b.vmcodigo                    AND
                      vmcodigo                       = @cMoneda
   END ELSE BEGIN
      SELECT          mnrrda,
                      mncodmon,
                      mnnemo,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      mncodmon
             FROM     VIEW_MONEDA
             WHERE    mnmx         = 'C'             AND
                      mncodmon     = @cMoneda
   END
END

GO
