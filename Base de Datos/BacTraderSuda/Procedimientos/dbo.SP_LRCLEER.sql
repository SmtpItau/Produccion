USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LRCLEER]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LRCLEER]
       (@nrutcli     numeric(09)     ,
        @cnombre     char(40)        ,
        @cusuario    char(15)      )
as
begin
   /*=======================================================================*/
   /* declaraci½n de variables.                                             */
   /*=======================================================================*/
   declare @nmonproc         numeric(03,00)
   declare @nmonlocal        numeric(03,00)
   declare @nvaloruf         float
   /*=======================================================================*/
   /*=======================================================================*/
   select @nmonproc  = 998
   select @nmonlocal = 999
   /*=======================================================================*/
   /* obtener el valor de d-a de la moneda utilizada.                       */
   /*=======================================================================*/
   select       @nvaloruf = vmvalor
          from  VIEW_VALOR_MONEDA , MDAC
          where acfecproc = vmfecha      and
                vmcodigo  = @nmonproc
   /*=======================================================================*/
   /*=======================================================================*/
   set rowcount 100
   select          'tmprutcli'    = clrut                ,
                   'tmpnombre'    = clnombre             ,
                   'tmpgeneric'   = clgeneric            ,
                   'tmppatrim'    = lrcpatrim            ,
                   'tmpfacsol'    = lrcfacsol            ,
                   'tmpporpatr'   = lrcporpatr           ,
                   'tmpporcart'   = lrcporcart           ,
                   'tmplinbase'   = lrclinbase           ,
                   'tmplinocup'   = lrclinocup           ,
                   'tmpsaldolre'  = lrcsaldo             ,
                   'tmpvaloruf'   = @nvaloruf            ,
                   'tmpsaldolru'  = lrcsaldo
          into     #TMPMDLRC
          from     VIEW_CLIENTE, MDLRC
          where    clnombre   >= @cnombre        and
                   clrut       = lrccliente
          order by clnombre
   set rowcount 0
        --and
--                   (clrut      = @nrutcli         or
--                    @nrutcli   = 0)
   /*=======================================================================*/
   /*=======================================================================*/
   update #TMPMDLRC
          set   tmpsaldolru = lrusaldo
          from  MDLRU
          where lrucliente = tmprutcli
   /*=======================================================================*/
   /*=======================================================================*/
   select          tmprutcli,
                   tmpnombre,
                   tmpgeneric,
                   tmppatrim,
                   tmpfacsol,
                   tmpporpatr,
                   tmpporcart,
                   tmplinbase,
                   tmplinocup,
                   tmpsaldolre,
                   tmpvaloruf,
                   tmpsaldolru
          from     #TMPMDLRC
          order by tmplinocup desc, tmplinbase desc
   /*=======================================================================*/
   /*=======================================================================*/
   drop table #TMPMDLRC
   /*=======================================================================*/
   /*=======================================================================*/
--   update bacuser set sw_MDLRC = '0' where usuario = @cusuario
   /*=======================================================================*/
   /*=======================================================================*/
   return 0
end


GO
