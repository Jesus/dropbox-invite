def try_block(default_value = nil)
  begin
    yield
  rescue
    return default_value
  end
end
