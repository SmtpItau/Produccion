USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FIN_DE_MES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FIN_DE_MES] ( @fecha char(8))
  
AS
BEGIN

SET NOCOUNT OFF

DECLARE @dfecfmes      datetime    ,
        @dFecFMesProx  datetime    ,
        @acfecprox     datetime    ,
        @fecha_emi     datetime    ,
        @acfecproc     datetime    ,
        @Fecha_Paso    datetime    ,
        @Fecha_Hoy     datetime    

DECLARE @Habil        char(1)

   SELECT  @acfecprox = acfecprox    ,
           @acfecproc = acfecproc
   FROM MDAC


   set @dfecfmes     = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)
   SET @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )
   SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx )

   set @Habil = ''
   SET @Fecha_Paso = @acfecprox

   EXECUTE sp_diahabil @Fecha_Paso OUTPUT

   IF DATEDIFF( DAY, @acfecproc , @Fecha_Paso ) = 1 BEGIN
      SET @Habil = 'S'
   END ELSE BEGIN
      SET @Habil = 'N'
   END

   IF @fecha = @dFecFMesProx BEGIN-- @dfecfmes  begin 
      select 1            -- fin de mes 
      return 
   END

  if @acfecproc = @dFecFMesProx  begin 
      select 1            -- fin de mes 
      return 
  end

  if @Habil     = 'S' and   @acfecproc = @dFecFMesProx  begin 
      select 1
      return   
  end

  if @Habil     = 'S' and   DATEDIFF( DAY, @acfecproc , @Fecha_Paso ) = 1  begin

     IF @fecha = @dfecfmes
     begin

      select 1            -- fin de mes 
      return 
    
     end else begin
        select 0                  -- diaria
        return 
     end
  end

  if @Habil     = 'N' and   datediff(month,@acfecproc ,@dFecFMesProx) = 0  begin 
    select 0
    return 
  end 

  if @Habil     = 'N' and   datediff(month,@acfecproc ,@dFecFMesProx) >= 1  begin 
    select 1             -- fin de mes 
    return 
  end 

END 


GO
