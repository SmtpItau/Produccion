USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERENCIA_TRAE_OPERACION]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_TRANSFERENCIA_TRAE_OPERACION] 
         (
            @fechaproc         datetime,
            @tipoper1           char(4),
            @tipoper2           char(4)
         )
as
begin 
         set nocount on
         select 
                moentidad             = ( select acnombre from MEAC )
               ,'swift_corresponsal'  = ( select c.nombre from VIEW_CORRESPONSAL c where m.swift_corresponsal = c.codigo_swift )
               ,movaluta1
               ,movaluta2
               ,momonmo
               ,'apoderado_izquierda' = ( select distinct apnombre
                                          from VIEW_CLIENTE_APODERADO
                                          where aprutapo = m.apoderado_izquierda and m.morutcli = aprutcli) 
               ,'apoderado_derecha'   = ( select distinct apnombre
                                           from VIEW_CLIENTE_APODERADO
                                           where aprutapo = m.apoderado_derecha and m.morutcli = aprutcli)
               ,monumope     
               ,moestatus        
               ,'swift_recibimos'     = ( select c.nombre from VIEW_CORRESPONSAL c where m.swift_recibimos = c.codigo_swift )
       from 
              MEMO m
       where
            m.motipmer = @tipoper1 and
            m.motipmer = @tipoper2 and
            m.mofech   = @fechaproc
 set nocount off
end



GO
