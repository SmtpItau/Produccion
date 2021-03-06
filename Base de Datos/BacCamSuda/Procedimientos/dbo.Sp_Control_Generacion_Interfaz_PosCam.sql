USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Control_Generacion_Interfaz_PosCam]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Control_Generacion_Interfaz_PosCam]
as
begin
 
	set nocount on

	select	Estado		= case	when isnull(Files.Cantidad, 0) > 0 then 'False' 
								else 'True' 
							end
		,	Registros	= isnull(Files.Cantidad, 0)
		,	Mensaje		= case	when	isnull(Files.Cantidad, 0) > 0 then 'Validación.'
									+	char(10) 
									+	char(10) 
									+	'Existen ' 
									+	ltrim(rtrim(isnull(Files.Cantidad, 0))) 
									+	' registros sin actualizar Folio Ibs.' 
									+	char(10) 
									+	char(10) 
									+	'No se puede Generar Interfaz [POSCAMMD].Dat '
								else	'Ok,  Se puede generar interfaz.'
							end
	from	(	select	Cantidad	= count(1)
				from	BacParamSuda.dbo.Planilla_Spt poscam with (nolock) 
				where	poscam.planilla_fecha		= (	select acfecpro from BacCamSuda.dbo.meac with(nolock) )
				and		poscam.NumeroPlanilla_IBS	= 0	--> Este campo se Cmpleta a Traves del Servicio Windows [Servicio PosCam]
			)	Files

end
GO
