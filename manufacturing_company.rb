module ManufacturingCompany
  

  def add_company(name)
    self.company_name = name
  end

  def show_company
    self.company_name
  end

  protected

  attr_accessor :company_name
end