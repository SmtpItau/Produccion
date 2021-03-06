USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OVERNIGHT_TRAE_OPERACION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_OVERNIGHT_TRAE_OPERACION]
         (
            @fechaproc         datetime,
            @tipoper1           char(4),
            @tipoper2           char(4)
         )
as
begin 
         set nocount on
         select 
               motipmer    ,      --mercado
               motipope    ,      --tipo. oper
               morutcli    ,      --rutcli
               mocodcli    ,      --codcli
               monomcli    ,      --nomcli
               mocodmon    ,      --codmoneda
               mocodcnv    ,      --usd   
               momonmo     ,      --monto
               moticam     ,      --tir
               movaluta2   ,      --fecha vcto
               momonpe     ,      --montofinal
               moentre     ,      --entragamos
               morecib     ,      --recibimos
               monumope    ,      --numero operacion
               contabiliza ,
               'glosa_pais'=(select nombre 
                                 from VIEW_PAIS 
                                 where codigo_pais = MEMO.casa_matriz),
               moestatus
            
       from 
               MEMO
      where 
            MOTIPMER = @tipoper1 or 
            MOTIPMER = @tipoper2 and
            mofech   = @fechaproc
set nocount off
end



GO
