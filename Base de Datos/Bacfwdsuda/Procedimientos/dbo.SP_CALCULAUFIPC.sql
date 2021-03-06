USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULAUFIPC]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CALCULAUFIPC]   
       (
        @mes      numeric(2,0)   ,
        @ultipc   numeric(6,2)   ,
        @ultuf    float       ,
        @nvaloruf numeric(12,2) output
                            )
AS
BEGIN
   DECLARE  @nmaxdia  NUMERIC(2,0) 
   DECLARE  @nipc     FLOAT
   SELECT @nmaxdia = 0
   /*=======================================================================*/
   IF  @mes =  1  BEGIN   SELECT @nmaxdia = 31  END --Enero
   IF  @mes =  2  BEGIN   SELECT @nmaxdia = 28  END --Febrero
   IF  @mes =  3  BEGIN   SELECT @nmaxdia = 31  END --Marzo
   IF  @mes =  4  BEGIN   SELECT @nmaxdia = 30  END --Abril
   IF  @mes =  5  BEGIN   SELECT @nmaxdia = 31  END --Mayo
   IF  @mes =  6  BEGIN   SELECT @nmaxdia = 30  END --Junio
   IF  @mes =  7  BEGIN   SELECT @nmaxdia = 31  END --Julio
   IF  @mes =  8  BEGIN   SELECT @nmaxdia = 31  END --Agosto
   IF  @mes =  9  BEGIN   SELECT @nmaxdia = 30  END --Septiembre
   IF  @mes = 10  BEGIN   SELECT @nmaxdia = 31  END --Octubre
   IF  @mes = 11  BEGIN   SELECT @nmaxdia = 30  END --Noviembre
   IF  @mes = 12  BEGIN   SELECT @nmaxdia = 31  END --Diciembre
-- IF (@Ano / 4) = CONVERT(NUMERIC(2),@Ano / 4) AND @mes= 2 BEGIN SELECT nMaxDia = 29 END
   SELECT @NIPC = (convert(float,@ultipc)/100) + 1
   
   SELECT @nvaloruf = convert(float,@nipc) * convert(float,@ultuf)
   /*=======================================================================*/
   RETURN 0
END

GO
