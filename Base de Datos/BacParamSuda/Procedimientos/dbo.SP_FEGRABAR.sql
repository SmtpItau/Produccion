USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FEGRABAR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_FeGrabar    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_FeGrabar    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_FEGRABAR](@feano1   NUMERIC (04,0),
                             @feplaza1 NUMERIC (03)  ,
                             @feene1   CHAR    (100)  ,  
                             @fefeb1   CHAR    (100)  ,
                             @femar1   CHAR    (100)  ,
                             @feabr1   CHAR    (100)  ,
                             @femay1   CHAR    (100)  ,
                             @fejun1   CHAR    (100)  ,
                             @fejul1   CHAR    (100)  ,
                             @feago1   CHAR    (100)  ,
                             @fesep1   CHAR    (100)  ,
                             @feoct1   CHAR    (100)  ,
                             @fenov1   CHAR    (100)  ,
                             @fedic1   CHAR    (100)  )
AS
BEGIN
SET NOCOUNT ON
       IF EXISTS(SELECT feano FROM FERIADO WHERE feano = @feano1  AND feplaza = @feplaza1) 
            UPDATE FERIADO SET feano   = @feano1,
                            feplaza = @feplaza1,
                            feene   = @feene1,
                            fefeb   = @fefeb1, 
                            femar   = @femar1, 
                            feabr   = @feabr1,
                            femay   = @femay1,
                            fejun   = @fejun1,
                            fejul   = @fejul1,
                            feago   = @feago1,
                            fesep   = @fesep1,
                            feoct   = @feoct1,
                            fenov   = @fenov1,
                            fedic   = @fedic1
                    WHERE   feano     = @feano1  
                    AND     feplaza   = @feplaza1
       ELSE
            INSERT INTO FERIADO   (  feano,   feplaza,   feene,   fefeb,   femar,   feabr,   femay,   fejun,   fejul,   feago,   fesep,   feoct,   fenov,   fedic  )
                        VALUES (@feano1, @feplaza1, @feene1, @fefeb1, @femar1, @feabr1, @femay1, @fejun1, @fejul1, @feago1, @fesep1, @feoct1, @fenov1, @fedic1  )
SET NOCOUNT OFF              
END
GO
