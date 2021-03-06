USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerCampos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerCampos]    Script Date: 27-11-2013 18:15:02 ******/

--==========================================================================       
-- Author		: Marcela Encina          
-- Create date  : 29-05-2013      
-- Description  : Obtiene los campos coincidentes a los sistemas consultados     
-- ==========================================================================  

CREATE PROCEDURE [dbo].[Wizard_ObtenerCampos]     
	@Fwd			AS VARCHAR(10) = '''',    
	@Swap			AS VARCHAR(10) = '''',    
	@Spot			AS VARCHAR(10) = '''',    
	@RentaFija		AS VARCHAR(10) = '''',     
	@InvExterior	AS VARCHAR(10) = '''',    
	@Opciones		AS VARCHAR(10) = '''',
	@MovCartera		AS INT = 0    
 
AS          
BEGIN          
      
	SET NOCOUNT ON;
	
	select	distinct 
			IdCampoDesc           = Campos.IdCampoDesc
		,   NombreCampoDesc       = Campos.NombreCampoDesc
    from	dbo.Tablas_Wizard Wizard with(nolock)
			inner join (	select	IdTabla           = Campo.IdTabla
                               ,    IdCampo           = Campo.IdCampo
                               ,    NombreCampo       = Campo.NombreCampo
                               ,    IdCampoDesc       = Campo.IdCampoDesc
                               ,    NombreCampoDesc   = CampoDesc.NombreCampoDesc
			            	FROM	(	select  IdTabla, IdCampo, NombreCampo, IdCampoDesc
										from	dbo.Campo   with(nolock)
									)   Campo
                                 inner join  (		select	IdCampoDesc, NombreCampoDesc
													from    dbo.CampoDesc     with(nolock)
                                              )		CampoDesc   On CampoDesc.IdCampoDesc = Campo.IdCampoDesc

						)    Campos      On    Campos.IdTabla    = Wizard.IdTabla

	where	Wizard.IdInstrumento    IN(select IdInstrumento from dbo.Instrumento where Sistema IN(@Fwd, @Swap, @Spot, @RentaFija, @InvExterior, @Opciones )     )
	and     Wizard.IdCmov			= @MovCartera
	and     -1                      <> (select Status      = min(Filtro.Status)
										from  (     select	Status            = case when IdCmov = @MovCartera then @MovCartera else -1 end
                                                    from    dbo.Tablas_Wizard with(nolock)
                                                    where   IdInstrumento     IN( (select IdInstrumento from dbo.Instrumento where Sistema IN(@Fwd, @Swap, @RentaFija, @InvExterior, @Opciones)) )
                                                    and     IdCmov            = @MovCartera
                                                           union
                                                    select  Status            = case when IdCmov = @MovCartera then @MovCartera else -1 end
                                                    from    dbo.Tablas_Wizard with(nolock)
                                                    where   IdInstrumento     = (select IdInstrumento from dbo.Instrumento where Sistema = @Spot )
                                               )    Filtro
                                       )
 
END
GO
