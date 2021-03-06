USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLON_PIE_SECCION3]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_PLANILLON_PIE_SECCION3]
            (
            @dfecha      char(8) ,
            @nposicion      int         ,
            @ncod_operacion int         ,
            @ntip_operacion int         ,
            @ncod_anulacion int  ,
            @ntip_anulacion int         ,
            @cdes_concepto  varchar(40) = ''
            )
as
begin
     set nocount on
     declare @ncnt_operacion int     ,
             @nmto_operacion float   ,
             @ncnt_anulacion int     ,
             @nmto_anulacion float
     execute Sp_Planillon_Calcula_Seccion3
             @dfecha                 ,
             @ncod_operacion         ,
             @ntip_operacion         ,
             @ncnt_operacion output  ,
             @nmto_operacion output
     execute Sp_Planillon_Calcula_Seccion3
             @dfecha                 ,
             @ncod_anulacion         ,
             @ntip_anulacion         ,
             @ncnt_anulacion output  ,
             @nmto_anulacion output
     select  posicion      = @nposicion           ,
             tipo          = substring(@cdes_concepto,1, 1),
             des_operacion = substring(@cdes_concepto,2,30),
             cod_operacion = isnull(@ncod_operacion,0 ) ,
             cnt_operacion = isnull(@ncnt_operacion,0 ) ,
             mto_operacion = isnull(@nmto_operacion,0.) ,
             cod_anulacion = isnull(@ncod_anulacion,0 ) ,
             cnt_anulacion = isnull(@ncnt_anulacion,0 ) ,
             mto_anulacion = isnull(@nmto_anulacion,0.) 
     set nocount off
end


GO
