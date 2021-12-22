CREATE DEFAULT [dbo].[DF_Security_RunningID]
    AS 'Desktop';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_Security_RunningID]', @objname = N'[dbo].[tcdsb_Security_applications].[Runing_ID]';

