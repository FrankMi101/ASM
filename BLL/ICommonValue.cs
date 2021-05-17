namespace BLL
{
    public interface ICommonValue<T>
    {
        string GeneralValue(object parameters);
        string GeneralValue( string sp, object parameters);
        string GeneralValue(object parameters, string page,string action);
    }
}
