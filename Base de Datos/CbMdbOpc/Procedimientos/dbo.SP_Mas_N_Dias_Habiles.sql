USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_Mas_N_Dias_Habiles]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_Mas_N_Dias_Habiles]
   (   @dFecha     DATETIME
   ,   @n          int
   ,   @dFecRet    DATETIME OUTPUT
   )
AS
BEGIN

/* Ejemplo Ejecución: 
declare  @FechaRet Datetime
exec dbo.SP_Mas_N_Dias_Habiles '20090520' , 4, @FechaRet output
select   @FechaRet


*/
   SET NOCOUNT ON

   declare 
         @iContaDia	 INTEGER
   ,     @MsgError       Varchar(80)

   Set DATEFIRST 7                  -- Para determinar el dábado y domingo correctamente   


   -- MAP 06 Octubre 
   -- Corrige reversos generados
   -- por formas de pago sin valuta
   if @n = 0 begin 
      select @dFecRet = @dFecha
      goto FinProcesoOK
   end
         

   create table #Resultado ( Resultado Varchar(2), Mensaje Varchar(100), Fecha Datetime , FechaProx DateTime )

   SELECT @iContaDia   = 1
   insert into #Resultado
   exec SP_FECHA_PROXIMA_HABIL @dFecha, @dFecRet output
   WHILE (1 = 1)
   BEGIN
      if @iContaDia < @n
      BEGIN
         Select @iContaDia = @iContaDia + 1
         insert into #Resultado
         exec SP_FECHA_PROXIMA_HABIL @dFecRet, @dFecRet output
      END ELSE
      BEGIN
         BREAK
      END
   END

FinProcesoOK: 
   return(0)
FinProcesoERROR:
   return(1)

END

GO
