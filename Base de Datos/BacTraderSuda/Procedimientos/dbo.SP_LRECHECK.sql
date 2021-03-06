USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LRECHECK]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LRECHECK]
       (@nemisor     numeric(09)     ,
        @dfecha      datetime        ,
        @nmonto      numeric(21,04)  )
as
begin
set nocount on
   /*=======================================================================*/
   /* declaraci½n de variables                                              */
   /*=======================================================================*/
   declare @nvaloruf   float
   declare @nmontomda  numeric(21,04)
   declare @nlinbase   numeric(21,04)
   declare @nlinocup   numeric(21,04)
   declare @nsaldo     numeric(21,04)
   declare @nmoneda    numeric(03)
   declare @cnombre    char(40)
   declare @cerror     char(02)
   /*=======================================================================*/
   /* asignaci½n de moneda en la cual estan expresadas las l-nea de riesgo  */
   /*=======================================================================*/
   select @nmoneda = 998
   /*=======================================================================*/
   /* recuperaci½n del valor de la moneda de l-nea de riesgo al la fecha    */
   /* que se esta indicando en 'dfecproc'.                                  */
   /*=======================================================================*/
   select       @nvaloruf = vmvalor
          from  VIEW_VALOR_MONEDA 
          where vmfecha   = @dfecha        and
                vmcodigo  = @nmoneda
   /*=======================================================================*/
   /* transformar  el  monto de la operaci½n  a la moneda de  la  l-nea  de */
   /* riesgo.                                                               */
   /*=======================================================================*/
   select @nmontomda = @nmonto / @nvaloruf
   /*=======================================================================*/
   /* recuperar el nombre del emisor                                        */
   /*=======================================================================*/
   select @cnombre = emnombre from  VIEW_EMISOR where emrut = @nemisor
   /*=======================================================================*/
   /* recuperar la l-nea asignada al emisor                                 */
   /*=======================================================================*/
   select          @nlinbase  = lrulinbase ,
                   @nlinocup  = lrulinocup ,
                   @nsaldo    = lrusaldo
          from     MDLRU
          where    lrucliente = @nemisor
---select          @nlinbase = lrdlinbase ,
---                @nlinocup = lrdlinocup ,
---                @nsaldo   = lrdsaldo
---       from     mdlrd, mdlrd
---       where    lreemisor = @nemisor
   /*=======================================================================*/
   /* chequeo de la l-nea del emisor                                        */
   /*=======================================================================*/
   if @nmontomda > @nsaldo  begin
      select @cerror = 'ER'
   end else begin
      select @cerror = 'OK'
   end
   /*=======================================================================*/
   /*=======================================================================*/
   select @cerror               ,
          @cnombre              ,
          @nlinbase             ,
          @nlinocup             ,
          @nsaldo               ,
          @nlinocup + @nmontomda,
          @nsaldo   - @nmontomda,
          @nmontomda
   /*=======================================================================*/
   /*=======================================================================*/
set nocount off
   return 0
end


GO
