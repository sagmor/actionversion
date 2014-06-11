class NumbersFixture
  include ActionVersion::Versionable

  version(10) do
    def version
      10
    end
  end

  version(20) do
    def version
      20
    end
  end

  version(30) do
    def version
      30
    end
  end

end
