CREATE DEFAULT [dbo].[DF_Security_Lock]
    AS 'LDB';


GO
EXECUTE sp_bindefault @defname = N'[dbo].[DF_Security_Lock]', @objname = N'[dbo].[tcdsb_Security_applications].[application_lockfile]';

