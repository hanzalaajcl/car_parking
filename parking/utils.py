from datetime import datetime

def convert_to_specific_format(input_date):
    try:
        # Try to parse the input date with various formats
        parsed_date = None
        possible_formats = ["%Y-%m-%d", "%d/%m/%Y", "%Y/%m/%d", "%Y-%m-%d %H:%M:%S"]
        
        for format_str in possible_formats:
            try:
                parsed_date = datetime.strptime(input_date, format_str)
                break  # Stop if parsing succeeds with any format
            except ValueError:
                continue  # Continue to the next format if parsing fails

        if parsed_date is None:
            # raise ValueError("Unable to determine the input date format.")
            return {'message':"Unable to determine the input date format.",'status':False}

        # Convert the parsed date to the desired format
        result_date = parsed_date.strftime('%Y-%m-%d')
        
        return {'date':result_date,'status':True}
    except ValueError as e:
        # Handle invalid date formats
        return {'status':False,'message':f'error {e}'}


