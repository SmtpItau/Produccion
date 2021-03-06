USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTAOPECONTR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_consultaopecontr    fecha de la secuencia de comandos: 05/04/2001 13:13:18 ******/
CREATE PROCEDURE [dbo].[SP_CONSULTAOPECONTR] (@ccodigo char)
as
begin
set nocount on
     /*-------------------------------------------------------*
      *       descripcion de los campos a utilizar            *
      *-------------------------------------------------------*
      *    numoper   , numero de operacion                    *
      *    rutcartera, rut de cartera                         *
      *    tipoper   , tipo de operaci½n                      *
      *    rutcli    , rut del cliente                        *
      *    nomcli    , nombre del cliente                     *
      *    totoper   , total operaci½n                        *
      *    horat     , hora de la transaccion                 *
      *    operador  , codigo del  operador                   *
      *    nomoper   , nombre del operador                    * 
      *-------------------------------------------------------*/
      -- declaro variable .-
      -------------------------------------------
      declare @cexecute char(120)  
      -- ordenamos por numero de operacion .-
      -------------------------------------------
        if @ccodigo = 'N'  
           begin
               select @cexecute = 'select numoper, tipoper, rutcartera, nomcli, totoper, horat, nomoper from #CONSULTAOPER order by numoper'
           end
      -- ordenamos por tipo de operacion .- 
      --------------------------------------------
        if @ccodigo = 'T'
           begin
               select @cexecute = 'select numoper, tipoper, rutcartera, nomcli, totoper, horat, nomoper from #CONSULTAOPER order by tipoper'
           end
      -- ordenamos por cliente .-
      -------------------------------------------
        if @ccodigo = 'C'  
           begin
               select @cexecute = 'select numoper, tipoper, rutcartera, nomcli, totoper, horat, nomoper from #CONSULTAOPER order by rutcli'
           end
 
      
      -- seleccionamos las operaciones .-
      -------------------------------------------
        select distinct 'numoper'    = monumoper, 
                        'rutcartera' = space(09), 
                        'tipoper'    = space(03), 
                        'rutcli'     = space(09),
                        'nomcli'     = space(40),
                        'totoper'    = space(30),
                        'horat'      = space(20),
                        'operador'   = space(15),
                        'nomoper'    = space(40)
        into     #CONSULTAOPER 
        from     MDMO
        where    MDMO.mostatreg is null and (
   motipoper = 'CP' or
   motipoper = 'CI' or
   motipoper = 'VP' or
   motipoper = 'VI' or
   motipoper = 'IB' ) and
                 MDMO.moinstser <> 'ICOL'
        
      -- actualizamos tabla campo de la tabla TEMPORAL .-
      ------------------------------------------------------        
      -- actualizamos tipo de operaciones de compras con pacto .-
      -----------------------------------------------------------
        update #CONSULTAOPER set tipoper    = motipoper, 
                                 rutcartera = convert(char(9),morutcart), 
                                 rutcli     = convert(char(9),morutcli),
                                 nomcli     = space(40),
                                 totoper    = space(30),
                                 horat      = mohora,
                                 operador   = mousuario,
                                 nomoper    = space(40)
        from     MDMO 
        where    numoper = MDMO.monumoper
        update #CONSULTAOPER set totoper  = convert(char(30),(select sum(movalcomp) from MDMO where numoper = monumoper ))
        from   MDMO 
        where  tipoper = 'CP' or tipoper = 'RC' or tipoper = 'RCA'  or tipoper = 'IB' 
        update #CONSULTAOPER set totoper    = convert(char(30),(select sum(movalven) from MDMO where numoper = monumoper ))
        from   MDMO
        where  tipoper = 'VP' or tipoper = 'RV' or tipoper = 'RVA' 
        update #CONSULTAOPER set totoper  = convert(char(30),(select sum(movalinip) from MDMO where numoper = monumoper ))
        from   MDMO 
        where  tipoper = 'CI' or tipoper = 'VI'
      -- buscamos el nombre del cliente 
      -- y las grabamos en la tabla TEMPORAL .-
      -----------------------------------------
        update #CONSULTAOPER set nomcli = VIEW_CLIENTE.clnombre
        from   VIEW_CLIENTE VIEW_CLIENTE
        where  convert(char(9),VIEW_CLIENTE.clrut) =  #CONSULTAOPER.rutcli
      -- buscamos el nombre del operador .-
      -----------------------------------------
        update #CONSULTAOPER set nomoper = nombre
        from   BACUSER
        where  operador = usuario
      -- seleccionamos solo los campos que
      -- deseamos mostrar .-
      -----------------------------------------  
        exec (@cexecute)
        return          
end


GO
